//
//  HomePresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 01.04.2022.
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    func setRecipeMinimalInfo(model: RandomRecipeCardModel?)
    func setErrorInfo()
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
    private var recipeRaw: RandomRecipeRaw?
    
    private var shouldUpdateView: Bool = false {
        didSet {
            switch shouldUpdateView {
            case true:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.homeView.setRecipeMinimalInfo(model: self.recipeModel)
                }
            case false:
                print("waiting")
            }
        }
    }
    
    init(view: HomeViewProtocol, imageLoader: ImageLoaderProtocol, networkService: RecipesServiceProtocol) {
        homeView = view
        self.imageLoader = imageLoader
        self.networkService = networkService
        recipeRaw = nil
    }
    
    func showRecipeMinimalInfo() {
        networkService.fetchRandomRecipes { [weak self] resultArray, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                self.homeView.setErrorInfo()
            }
            
            if let resultArray = resultArray {
                self.recipeRaw = resultArray[0]
                self.prepareToShowRecipeInfo(from: resultArray[0])
            }
        }
    }
}

extension HomePresenter {
    private func prepareToShowRecipeInfo(from result: RandomRecipeRaw) {
        var model = RandomRecipeCardModel(title: result.title, ready: result.readyInMinutes, dishType: result.dishTypes, img: nil)
        if let url = URL(string: result.image) {
            imageLoader.loadImage(from: url) { [weak self] image in
                model.img = image
                self?.recipeModel = model
                self?.shouldUpdateView = true
            }
        } else {
            recipeModel = model
            shouldUpdateView = true
        }
    }
}
