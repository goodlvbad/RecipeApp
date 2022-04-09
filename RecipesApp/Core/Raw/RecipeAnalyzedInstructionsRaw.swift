//
//  RecipeAnalyzedInstructionsRaw.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 09.04.2022.
//

import Foundation

struct RecipeAnalyzedInstructionsResponse: Responsable {
    let array: [RecipeAnalyzedInstructionsRaw]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([RecipeAnalyzedInstructionsRaw].self)
        array = values
    }
}

struct RecipeAnalyzedInstructionsRaw: Codable {
    let name: String
    let steps: [Steps]
}

struct Steps: Codable {
    let number: Int
    let step: String
}
