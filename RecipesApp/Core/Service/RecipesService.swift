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
}

final class RecipesService {
    private let network = NetworkCore.shared
}

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
}
