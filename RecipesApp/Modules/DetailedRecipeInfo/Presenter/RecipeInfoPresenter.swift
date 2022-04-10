//
//  RecipeInfoPresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 09.04.2022.
//

import Foundation
import UIKit

protocol RecipeInfoViewProtocol: AnyObject {
    func showRecipeInfo(title: String?, ready: String?, servings: String?, recipeInfo: String?)
    func showError()
    func changeFavoriteButton(saved: Bool)
}

protocol RecipeInfoPresenterProtocol: AnyObject {
    
    init(view: RecipeInfoViewProtocol,
         networkService: RecipesServiceProtocol,
         imageLoader: ImageLoaderProtocol,
         recipeId: Int,
         dishImage: UIImage?,
         isFavorite: Bool)
    
    var dishImage: UIImage? { get }
    var ingredients: [IngredientsModel] { get }
    
    func manageSettingToFavorite()
    func manageGettingInfo()
}

final class RecipeInfoPresenter: RecipeInfoPresenterProtocol {
    
    private let view: RecipeInfoViewProtocol
    private let networkService: RecipesServiceProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let recipeId: Int
    private var isFavorite: Bool
    
    private var dishImageStr: String?
    
    var dishImage: UIImage?
    
    var ingredients: [IngredientsModel] = []
    var recipeInfoModel: RecipeInfoModel?
    
    var favoriteRecipe: FavoriteRecipe?
    
    private var shouldUpdateView: Bool = false {
        didSet {
            if shouldUpdateView == true {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.view.showRecipeInfo(title: self.recipeInfoModel?.title,
                                             ready: self.recipeInfoModel?.ready,
                                             servings: self.recipeInfoModel?.servings,
                                             recipeInfo: self.recipeInfoModel?.recipeText)
                }
            }
        }
    }
    
    init(view: RecipeInfoViewProtocol,
         networkService: RecipesServiceProtocol,
         imageLoader: ImageLoaderProtocol,
         recipeId: Int,
         dishImage: UIImage?,
         isFavorite: Bool)
    {
        self.view = view
        self.networkService = networkService
        self.imageLoader = imageLoader
        self.recipeId = recipeId
        self.dishImage = dishImage
        self.isFavorite = isFavorite
    }
    
    func manageSettingToFavorite() {
        switch isFavorite {
        case true:
            removeRecipeFromFavorites()
        case false:
            saveRecipeToFavorites()
        }
    }
    
    func manageGettingInfo() {
        switch isFavorite {
        case true:
            print("show info from coredata")
        case false:
            getRecipeInfo()
            getRecipeInstructions()
        }
    }
}

//MARK: - Private methods
extension RecipeInfoPresenter {
    private func getRecipeInfo() {
        networkService.fetchRecipeInfo(id: recipeId) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.view.showError()
                }
            }
            if let result = result {
                self.dishImageStr = result.image
                self.recipeInfoModel = RecipeInfoModel(title: result.title,
                                                       ready: String(result.readyInMinutes),
                                                       servings: String(result.servings),
                                                       recipeText: nil)
                self.prepareIngredientsData(from: result.extendedIngredients)
            }
        }
    }
    
    private func getRecipeInstructions() {
        networkService.fetchRecipeAnalyzedInstructions(id: recipeId) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.view.showError()
                }
            }
            if let result = result {
                var text = ""
                for stepCount in 0..<result[0].steps.count {
                    let str = result[0].steps[stepCount].step + " "
                    text.append(contentsOf: str)
                }
                self.recipeInfoModel?.recipeText = text
            }
        }
    }

    private func prepareIngredientsData(from result: [ExtendedIngredients]) {
        ingredients = []
        var counter = 0
        for raw in result {
            let urlStr = "https://spoonacular.com/cdn/ingredients_100x100/" + raw.image
            var model = IngredientsModel(id: raw.id, imageString: urlStr, image: nil, name: raw.original)
            if let url = URL(string: urlStr) {
                imageLoader.loadImage(from: url) { [weak self] img in
                    model.image = img
                    self?.ingredients.append(model)
                    counter += 1
                    if counter == result.count - 1 {
                        self?.shouldUpdateView = true
                    }
                }
            } else {
                ingredients.append(model)
                counter += 1
                if counter == result.count - 1 {
                    shouldUpdateView = true
                }
            }
        }
    }
    
    private func saveRecipeToFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newFavoriteRecipe = FavoriteRecipe(context: managedContext)
        newFavoriteRecipe.id = Int64(recipeId)
        newFavoriteRecipe.titile = recipeInfoModel?.title
        newFavoriteRecipe.readyInMinutes = recipeInfoModel?.ready
        newFavoriteRecipe.recipeInfo = recipeInfoModel?.recipeText
        newFavoriteRecipe.image = dishImageStr
        
        var ingridientsArray = [Ingridients]()
        
        for ingridient in ingredients {
            let newIngredient = Ingridients(context: managedContext)
            newIngredient.info = ingridient.name
            newIngredient.image = ingridient.imageString
            newIngredient.id = Int64(ingridient.id)
            ingridientsArray.append(newIngredient)
        }
        
        newFavoriteRecipe.ingridients = NSSet(array: ingridientsArray)
        
        do {
            try managedContext.save()
            favoriteRecipe = newFavoriteRecipe
            isFavorite = true
            view.changeFavoriteButton(saved: true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func removeRecipeFromFavorites() {
        guard let favoriteRecipe = favoriteRecipe else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(favoriteRecipe)
        do {
            try managedContext.save()
            isFavorite = false
            view.changeFavoriteButton(saved: false)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
