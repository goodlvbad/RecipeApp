//
//  ListOfRandomRecipeResponse.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation

struct ListOfRandomRecipeResponse: Responsable {
    let recipes: [RandomRecipeRaw]
}
