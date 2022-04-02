//
//  SearchPresenter.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 02.04.2022.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func setSuccessSearchResult()
    func setFailureSearchResult()
    func setWaiting()
}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, imageLoader: ImageLoaderProtocol, networkService: RecipesServiceProtocol)
    func searchResipe(query: String?)
    var recipes: [RecipeViewModel] { get }
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
                mainView.setSuccessSearchResult()
            case false:
                mainView.setWaiting()
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
//                    self.mainView.setFailureSearchResult()
                }
                
                if let resultArray = resultArray {
                    self.prepareToShowData(from: resultArray)
                }
            }
        } else {
            print("add nil handler of search string")
//            self.mainView.setFailureSearchResult()
        }
        
    }
}

extension SearchPresenter {
    private func setAnotherSeparator(to string: String) -> String {
        if string.contains(" ") {
            let array = string.split(separator: " ")
            var newString = ""
            for substring in array {
                newString.append(contentsOf: substring)
                newString.append("&")
            }
            newString.removeLast()
            return newString
        } else {
            return string
        }
    }
    
    private func prepareToShowData(from result: [RecipeRaw]) {
        recipes = []
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
