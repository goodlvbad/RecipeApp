//
//  Builder.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 01.04.2022.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    static func createSearchModule() -> UIViewController
    static func createDetailedRecipeInfoModule(_ id: Int, _ image: UIImage?, _ isFavorite: Bool ) -> UIViewController
    static func createFavoritesModule() -> UIViewController
}

final class Builder: BuilderProtocol {
    static func createSearchModule() -> UIViewController {
        let view = SearchViewController()
        let imageLoader = ImageLoader()
        let service = RecipesService()
        let presenter = SearchPresenter(view: view, imageLoader: imageLoader, networkService: service)
        view.presenter = presenter
        
        return view
    }
    
    static func createDetailedRecipeInfoModule(_ id: Int, _ image: UIImage?, _ isFavorite: Bool ) -> UIViewController {
        let view = RecipeInfoViewController()
        let service = RecipesService()
        let imageLoader = ImageLoader()
        let presenter = RecipeInfoPresenter(view: view, networkService: service, imageLoader: imageLoader, recipeId: id, dishImage: image, isFavorite: isFavorite)
        view.presenter = presenter
        
        return view
    }
    
    static func createFavoritesModule() -> UIViewController {
        let view = FavoritesViewController()
        let imageLoader = ImageLoader()
        let presenter = FavoritesPresenter(view: view, imageLoader: imageLoader)
        view.presenter = presenter
        
        return view
    }
}
