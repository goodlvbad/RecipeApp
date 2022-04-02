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
    init(view: HomeViewProtocol, model: RandomRecipeCardModel, imageLoader: ImageLoaderProtocol)
    func showRecipeMinimalInfo()
}

final class HomePresenter: HomePresenterProtocol {
    
    private let homeView: HomeViewProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let recipeModel: RandomRecipeCardModel
    
    init(view: HomeViewProtocol, model: RandomRecipeCardModel, imageLoader: ImageLoaderProtocol) {
        homeView = view
        recipeModel = model
        self.imageLoader = imageLoader
    }
    
    func showRecipeMinimalInfo() {
        
//        print(homeView)
        
        let title = recipeModel.title
        var ready: String?
        if recipeModel.ready == 0 {
            ready = nil
        } else {
            ready = String(recipeModel.ready)
        }
        let type = recipeModel.dishType
        
        if let url = URL(string: recipeModel.img) {
            imageLoader.loadImage(from: url) { [weak self] img in
                guard let self = self else { return }
                self.homeView.setRecipeMinimalInfo(title: title, ready: ready, dishType: type, image: img)
            }
        } else {
            homeView.setRecipeMinimalInfo(title: title, ready: ready, dishType: type, image: nil)
        }
    }
}
