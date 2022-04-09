//
//  RecipeInfoResponse.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 09.04.2022.
//

import Foundation

struct RecipeInfoResponse: Codable, Responsable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let servings: Int
    let dishTypes: [String]
    let extendedIngredients: [Ingredients]
}
