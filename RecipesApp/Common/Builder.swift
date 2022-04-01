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
}

final class Builder: BuilderProtocol {
    static func createHomeModule() -> UIViewController {
        
        let model = RandomRecipeCardModel.init(title: "Delicious, adorable, pleasant, enjoyable",
                                               ready: 30,
                                               dishType: [
                                                "lunch",
                                                "main course",
                                                "main dish",
                                                "dinner"],
                                               img: img)
        
//        let model = RandomRecipeCardModel.init(title: "",
//                                               ready: 0,
//                                               dishType: [],
//                                               img: "")
        
        let view = HomeViewController()
        let imageLoader = ImageLoader()
        let presenter = HomePresenter(view: view, model: model, imageLoader: imageLoader)
        view.presenter = presenter
        return view
    }
}
