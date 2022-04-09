//
//  RecipeInfoViewController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 09.04.2022.
//

import Foundation
import UIKit

final class RecipeInfoViewController: UIViewController {
    
    var presenter: RecipeInfoPresenterProtocol?
    
    private let cellId = "ingredientsCellId"
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2))
        return imageView
    }()
    
    private lazy var recipeInfoView = RecipeStepsView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height / 2))
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(IngredientsTableCell.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        presenter?.getRecipeInfo()
        presenter?.getRecipeInstructions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2)
        recipeInfoView.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height / 2)
        ingredientsTableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
    }
    
}

//MARK: - Private methods
extension RecipeInfoViewController {
    private func configureView() {
        view.addSubview(scrollView)
        scrollView.addSubviews([
            imageView,
            recipeInfoView,
            ingredientsTableView
        ])
    }
}

//MARK: - RecipeInfoViewProtocol
extension RecipeInfoViewController: RecipeInfoViewProtocol {
    func setRecipeInfo() {
        imageView.image = presenter?.dishImage
        recipeInfoView.setRecipeInfo(title: "Title", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ipsum tristique risus libero in consectetur suscipit enim malesuada risus. Gravida vitae ac habitant scelerisque.", ready: "45", servings: "4")
    }
}

//MARK: - UIScrollViewDelegate
extension RecipeInfoViewController: UIScrollViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension RecipeInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IngredientsTableCell
        
        cell.setupCell(title: "IngredientsTableCell", image: presenter?.dishImage)
        
//        if let isEmpty = presenter?.recipes.isEmpty {
//            if !isEmpty {
//                if let data = presenter?.recipes[indexPath.row] {
//                    cell.setupCell(titile: data.title, image: data.image)
//                }
//            }
//        } else {
//            cell.setupCell(titile: nil, image: nil)
//        }

        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension RecipeInfoViewController: UITableViewDelegate {
    
}
