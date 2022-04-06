//
//  HomePresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 01.04.2022.
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    func setRecipeMinimalInfo(title: String, ready: String?, dishType: [String], image: UIImage?)
}

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, imageLoader: ImageLoaderProtocol, networkService: RecipesServiceProtocol)
    func showRecipeMinimalInfo()
}

final class HomePresenter: HomePresenterProtocol {
    
    private let homeView: HomeViewProtocol
    private let imageLoader: ImageLoaderProtocol
    private let networkService: RecipesServiceProtocol
    
    private var recipeModel: RandomRecipeCardModel?
    
    init(view: HomeViewProtocol, imageLoader: ImageLoaderProtocol, networkService: RecipesServiceProtocol) {
        homeView = view
        self.imageLoader = imageLoader
        self.networkService = networkService
        recipeModel = nil
    }
    
    func showRecipeMinimalInfo() {
        networkService.fetchRandomRecipes { [weak self] resultArray, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                
            }
            
            if let resultArray = resultArray {
                print(resultArray)
                
            }
        }
    }
    
    
}
