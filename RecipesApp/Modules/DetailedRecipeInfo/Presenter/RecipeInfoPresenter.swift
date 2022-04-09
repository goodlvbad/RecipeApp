//
//  RecipeInfoPresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 09.04.2022.
//

import Foundation
import UIKit

protocol RecipeInfoViewProtocol: AnyObject {
    func setRecipeInfo()
}

protocol RecipeInfoPresenterProtocol: AnyObject {
    init(view: RecipeInfoViewProtocol, networkService: RecipesServiceProtocol, recipeId: Int, dishImage: UIImage?)
    var dishImage: UIImage? { get }
    func getRecipeInfo()
    func getRecipeInstructions()
}

final class RecipeInfoPresenter: RecipeInfoPresenterProtocol {
    
    private let view: RecipeInfoViewProtocol
    private let networkService: RecipesServiceProtocol
    
    private let recipeId: Int
    
    var dishImage: UIImage?
    
    init(view: RecipeInfoViewProtocol, networkService: RecipesServiceProtocol, recipeId: Int, dishImage: UIImage?) {
        self.view = view
        self.networkService = networkService
        self.recipeId = recipeId
        self.dishImage = dishImage
    }
    
    func getRecipeInfo() {
        networkService.fetchRecipeInfo(id: recipeId) { result, error in
            if let error = error {
                print(error)
            }
            if let result = result {
                print(result)
            }
        }
        view.setRecipeInfo()
    }
    
    func getRecipeInstructions() {
        networkService.fetchRecipeAnalyzedInstructions(id: recipeId) { result, error in
            if let error = error {
                print(error)
            }
            if let result = result {
                print(result)
            }
        }
    }
    
}
