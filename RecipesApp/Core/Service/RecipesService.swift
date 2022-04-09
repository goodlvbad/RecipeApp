//
//  RecipesService.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation

protocol RecipesServiceProtocol: AnyObject {
    func fetchRandomRecipes(comletion: @escaping (_ resultArray: [RandomRecipeRaw]?, _ error: Error?) -> Void)
    func fetchRecipes(query: String, comletion: @escaping (_ resultArray: [RecipeRaw]?, _ error: Error?) -> Void)
    func fetchRecipeInfo(id: Int, comletion: @escaping (_ result: RecipeInfoResponse?, _ error: Error?) -> Void)
    func fetchRecipeAnalyzedInstructions(id: Int, comletion: @escaping (_ result: [RecipeAnalyzedInstructionsRaw]?, _ error: Error?) -> Void)
}

final class RecipesService {
    private let network = NetworkCore.shared
}

//MARK: - RecipesServiceProtocol
extension RecipesService: RecipesServiceProtocol {
    func fetchRandomRecipes(comletion: @escaping (_ resultArray: [RandomRecipeRaw]?, _ error: Error?) -> Void) {
        let metadata = "recipes/random?number=1"
        network.request(metadata: metadata) { (result: Result<ListOfRandomRecipeResponse, NetworkError>) in
            switch result {
            case .success(let response):
                comletion(response.recipes, nil)
            case .failure(let error):
                comletion(nil, error)
            }
        }
    }
    
    func fetchRecipes(query: String, comletion: @escaping (_ resultArray: [RecipeRaw]?, _ error: Error?) -> Void) {
        let metadata = "recipes/complexSearch?query=\(query)"
        network.request(metadata: metadata) { (result: Result<RecipeResponseResult, NetworkError>) in
            switch result {
            case .success(let response):
                comletion(response.results, nil)
            case .failure(let error):
                comletion(nil, error)
            }
        }
    }
    
    func fetchRecipeInfo(id: Int, comletion: @escaping (_ result: RecipeInfoResponse?, _ error: Error?) -> Void) {
        let metadata = "recipes/\(id)/information?includeNutrition=false"
        network.request(metadata: metadata) { (result: Result<RecipeInfoResponse, NetworkError>) in
            switch result {
            case .success(let response):
                comletion(response, nil)
            case .failure(let error):
                comletion(nil, error)
            }
        }
    }
    
    func fetchRecipeAnalyzedInstructions(id: Int, comletion: @escaping (_ result: [RecipeAnalyzedInstructionsRaw]?, _ error: Error?) -> Void) {
        let metadata = "recipes/\(id)/analyzedInstructions?stepBreakdown=true"
        network.request(metadata: metadata) { (result: Result<RecipeAnalyzedInstructionsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                comletion(response.array, nil)
            case .failure(let error):
                comletion(nil, error)
            }
        }
    }
}
