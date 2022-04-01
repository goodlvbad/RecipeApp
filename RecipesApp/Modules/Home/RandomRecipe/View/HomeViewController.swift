//
//  HomeViewController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation
import UIKit

let img = "https://spoonacular.com/recipeImages/640117-556x370.jpg"

final class HomeViewController: UIViewController {

    var presenter: HomePresenterProtocol?
    
    private lazy var recipeCard = RandomRecipeCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recipe of the day"
        
        print(presenter)
        
        presenter?.showRecipeMinimalInfo()
        
        configureRecipeCard()
    }
}

extension HomeViewController {
    private func configureRecipeCard() {
        
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(recipeCard)
        recipeCard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            recipeCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recipeCard.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recipeCard.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
    }
    
    private func actionForMoreButton() {
        
    }
}

extension HomeViewController: HomeViewProtocol {
    func setRecipeMinimalInfo(title: String, ready: String?, dishType: [String], image: UIImage?) {
        recipeCard.setRecipeMinimalInfo(title: title, ready: ready, dishType: dishType, image: image)
    }
}
