//
//  FavoritesPresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 10.04.2022.
//

import UIKit
import CoreData

protocol FavoritesViewProtocol: AnyObject {
    func updateView()
}

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesViewProtocol, imageLoader: ImageLoaderProtocol)
    var recipes: [FavoriteRecipeViewModel] { get }
    func loadRecipe()
    func removeRecipeFromFavorites(_ index: Int)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    private let view: FavoritesViewProtocol
    private let imageLoader: ImageLoaderProtocol
    
    var recipes: [FavoriteRecipeViewModel] = []
    var recipesCoreData: [FavoriteRecipe] = []
    
    init(view: FavoritesViewProtocol, imageLoader: ImageLoaderProtocol) {
        self.view = view
        self.imageLoader = imageLoader
    }
    
    func loadRecipe() {
        recipes.removeAll()
        view.updateView()
        getFavoriteRecipes()
        var counter = 0
        let lastIteration = recipesCoreData.count - 1
        for recipe in recipesCoreData {
            let imageStr = recipe.image ?? ""
            var model = FavoriteRecipeViewModel(title: recipe.titile, readyInMinutes: recipe.readyInMinutes, recipeImage: nil)
            if let url = URL(string: imageStr) {
                imageLoader.loadImage(from: url) { [weak self] image in
                    model.recipeImage = image
                    self?.recipes.append(model)
                    if counter == lastIteration {
                        self?.view.updateView()
                    }
                    counter += 1
                }
            } else {
                recipes.append(model)
                if counter == lastIteration {
                    view.updateView()
                }
                counter += 1
            }
        }
    }
    
    func removeRecipeFromFavorites(_ index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let recipeToRemove = recipesCoreData[index]
        managedContext.delete(recipeToRemove)
        do {
            try managedContext.save()
            recipes.remove(at: index)
            view.updateView()
        } catch let error as NSError {
            print("Could not remove. \(error), \(error.userInfo)")
        }
    }
}

extension FavoritesPresenter {
    private func getFavoriteRecipes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        recipesCoreData.removeAll()
        do {
            recipesCoreData = try managedContext.fetch(FavoriteRecipe.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
