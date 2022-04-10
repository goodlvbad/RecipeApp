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
    
    enum FavoriteButtonImage: String {
        case unsaved = "suit.heart"
        case saved = "suit.heart.fill"
    }
    
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
        configureNavigationBar()
        presenter?.manageGettingInfo()
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
    private func configureNavigationBar() {
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: FavoriteButtonImage.unsaved.rawValue), style: .plain, target: self, action: #selector(didTapFavoriteButton))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func configureView() {
        view.addSubview(scrollView)
        scrollView.addSubviews([
            imageView,
            recipeInfoView,
            ingredientsTableView
        ])
    }
    
    @objc
    private func didTapFavoriteButton() {
        presenter?.manageSettingToFavorite()
    }
}

//MARK: - RecipeInfoViewProtocol
extension RecipeInfoViewController: RecipeInfoViewProtocol {
    func changeFavoriteButton(saved: Bool) {
        switch saved {
        case true:
            let img = UIImage(systemName: FavoriteButtonImage.saved.rawValue)
            navigationItem.rightBarButtonItem?.image = img
        case false:
            let img = UIImage(systemName: FavoriteButtonImage.unsaved.rawValue)
            navigationItem.rightBarButtonItem?.image = img
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Something goes wrong", message: "Try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRecipeInfo(title: String?, ready: String?, servings: String?, recipeInfo: String?) {
        imageView.image = presenter?.dishImage
        recipeInfoView.setRecipeInfo(title: title, ready: ready, servings: servings, text: recipeInfo)
        ingredientsTableView.reloadData()
    }
}

//MARK: - UIScrollViewDelegate
extension RecipeInfoViewController: UIScrollViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension RecipeInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IngredientsTableCell

        if let isEmpty = presenter?.ingredients.isEmpty {
            if !isEmpty {
                if let data = presenter?.ingredients[indexPath.row] {
                    cell.setupCell(title: data.name, image: data.image)
                }
            }
        } else {
            cell.setupCell(title: nil, image: nil)
        }

        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension RecipeInfoViewController: UITableViewDelegate {
    
}
