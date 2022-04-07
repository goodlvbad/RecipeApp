//
//  HomeViewController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {

    var presenter: HomePresenterProtocol?
    
    private lazy var recipeCard = RandomRecipeCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureRecipeCard()
        presenter?.showRecipeMinimalInfo()
    }
}

extension HomeViewController {
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Recipe of the day"
    }
    
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

    func setRecipeMinimalInfo(model: RandomRecipeCardModel?) {
        if let model = model {
            recipeCard.setRecipeMinimalInfo(title: model.title, ready: String(model.ready), dishType: model.dishType, image: model.img)
        } else {
            setErrorInfo()
        }
    }
    
    func setErrorInfo() {
        print("show error info")
    }
}
