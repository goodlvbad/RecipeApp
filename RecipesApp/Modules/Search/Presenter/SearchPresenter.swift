//
//  SearchPresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 02.04.2022.
//

import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    func showSuccessSearchResult()
    func showFailureSearchResult()
    func showWaiting()
    func showEmptyResult()
    func showDetailedRecipeInformation(_ view: UIViewController)
}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, imageLoader: ImageLoaderProtocol, networkService: RecipesServiceProtocol)
    var recipes: [RecipeViewModel] { get }
    func searchResipe(query: String?)
    func getDetailedRecipeInformation(from index: Int)
}

final class SearchPresenter: SearchPresenterProtocol {
    
    private let mainView: SearchViewProtocol
    private let imageLoader: ImageLoaderProtocol
    private let networkService: RecipesServiceProtocol
    
    var recipes: [RecipeViewModel] = []
    
    private var shouldUpdateView: Bool = false {
        didSet {
            switch shouldUpdateView {
            case true:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.mainView.showSuccessSearchResult()
                }
            case false:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.mainView.showWaiting()
                }
            }
        }
    }
    
    private var shouldShowEmptyResult: Bool = false {
        didSet {
            if shouldShowEmptyResult == true {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.mainView.showEmptyResult()
                }
            }
        }
    }

    init(view: SearchViewProtocol, imageLoader: ImageLoaderProtocol, networkService: RecipesServiceProtocol) {
        mainView = view
        self.imageLoader = imageLoader
        self.networkService = networkService
    }
    
    func searchResipe(query: String?) {
        if let query = query {
            let str = setAnotherSeparator(to: query)
            networkService.fetchRecipes(query: str) { [weak self] resultArray, error in
                guard let self = self else { return }
                if let error = error {
                    print(error)
                    self.mainView.showFailureSearchResult()
                }
                
                if let resultArray = resultArray {
                    self.prepareToShowData(from: resultArray)
                }
            }
        }
    }
    
    func getDetailedRecipeInformation(from index: Int) {
        let id = recipes[index].id
        let image = recipes[index].image
        let vc = Builder.createDetailedRecipeInfoModule(id, image)
        mainView.showDetailedRecipeInformation(vc)
    }
}

//MARK: - Private methods
extension SearchPresenter {
    private func setAnotherSeparator(to string: String) -> String {
        if string.contains(" ") {
            let array = string.split(separator: " ")
            var newString = ""
            for substring in array {
                newString.append(contentsOf: substring)
                newString.append("+")
            }
            newString.removeLast()
            return newString
        } else {
            return string
        }
    }
    
    private func prepareToShowData(from result: [RecipeRaw]) {
        recipes = []
        shouldUpdateView = false
        if result.count == 0 {
            shouldShowEmptyResult = true
            return
        } else {
            var counter = 0
            for raw in result {
                var model = RecipeViewModel(id: raw.id, title: raw.title, image: nil)
                if let url = URL(string: raw.image) {
                    imageLoader.loadImage(from: url) { [weak self] img in
                        model.image = img
                        self?.recipes.append(model)
                        counter += 1
                        if counter == result.count - 1 {
                            self?.shouldUpdateView = true
                        }
                    }
                } else {
                    recipes.append(model)
                    counter += 1
                    if counter == result.count - 1 {
                        shouldUpdateView = true
                    }
                }
            }
        }
    }
}
