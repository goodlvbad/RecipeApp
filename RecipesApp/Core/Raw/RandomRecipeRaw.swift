//
//  RecipeRaw.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation

struct RandomRecipeRaw: Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let servings: Int
    let dishTypes: [String]
    let extendedIngredients: [ExtendedIngredients]
}

struct ExtendedIngredients: Codable {
    let id: Int
    let aisle: String
    let image: String
    let name: String
    let original: String
    let originalName: String
    let unit: String
//    let amount: Int
//    let measures: [Measures]
}

//struct Measures: Codable {
//    let us: [USMetric]
//    let metric: [InternationalMetric]
//}
//
//struct InternationalMetric: Codable {
//    let amount: Float
//    let unitShort: String
//    let unitLong: String
//}
//
//struct USMetric: Codable {
//    let amount: Int
//    let unitShort: String
//    let unitLong: String
//}

