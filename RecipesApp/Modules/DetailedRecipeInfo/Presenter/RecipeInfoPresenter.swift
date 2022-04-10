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
}

protocol RecipeInfoPresenterProtocol: AnyObject {
    
    init(view: RecipeInfoViewProtocol,
         networkService: RecipesServiceProtocol,
         imageLoader: ImageLoaderProtocol,
         recipeId: Int,
         dishImage: UIImage?)
    
    var dishImage: UIImage? { get }
    var ingredients: [IngredientsModel] { get }
    func getRecipeInfo()
    func getRecipeInstructions()
}

final class RecipeInfoPresenter: RecipeInfoPresenterProtocol {
    
    private let view: RecipeInfoViewProtocol
    private let networkService: RecipesServiceProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let recipeId: Int
    
    var dishImage: UIImage?
    
    var ingredients: [IngredientsModel] = []
    var recipeInfoModel: RecipeInfoModel?
    
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
         dishImage: UIImage?)
    {
        self.view = view
        self.networkService = networkService
        self.imageLoader = imageLoader
        self.recipeId = recipeId
        self.dishImage = dishImage
    }
    
    func getRecipeInfo() {
        networkService.fetchRecipeInfo(id: recipeId) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.view.showError()
                }
            }
            if let result = result {
                self.recipeInfoModel = RecipeInfoModel(title: result.title,
                                                       ready: String(result.readyInMinutes),
                                                       servings: String(result.servings),
                                                       recipeText: nil)
                self.prepareIngredientsData(from: result.extendedIngredients)
            }
        }
    }
    
    func getRecipeInstructions() {
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
}

//MARK: - Private methods
extension RecipeInfoPresenter {
    private func prepareIngredientsData(from result: [Ingredients]) {
        ingredients = []
        var counter = 0
        for raw in result {
            var model = IngredientsModel(image: nil, name: raw.original)
            let urlStr = "https://spoonacular.com/cdn/ingredients_100x100/" + raw.image
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
}
