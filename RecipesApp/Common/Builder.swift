//
//  Builder.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 01.04.2022.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    static func createHomeModule() -> UIViewController
    static func createSearchModule() -> UIViewController
    static func createDetailedRecipeInfoModule(_ id: Int, _ image: UIImage?) -> UIViewController
}

final class Builder: BuilderProtocol {
    static func createHomeModule() -> UIViewController {
        let view = HomeViewController()
        let imageLoader = ImageLoader()
        let service = RecipesService()
        let presenter = HomePresenter(view: view, imageLoader: imageLoader, networkService: service)
        view.presenter = presenter
        
        return view
    }
    
    static func createSearchModule() -> UIViewController {
        let view = SearchViewController()
        let imageLoader = ImageLoader()
        let service = RecipesService()
        let presenter = SearchPresenter(view: view, imageLoader: imageLoader, networkService: service)
        view.presenter = presenter
        
        return view
    }
    
    static func createDetailedRecipeInfoModule(_ id: Int, _ image: UIImage?) -> UIViewController {
        let view = RecipeInfoViewController()
        let service = RecipesService()
        let presenter = RecipeInfoPresenter(view: view, networkService: service, recipeId: id, dishImage: image)
        view.presenter = presenter
        
        return view
    }
}
