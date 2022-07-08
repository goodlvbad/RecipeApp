//
//  FavoritesViewController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation
import UIKit

final class FavoritesViewController: UIViewController {
    
    var presenter: FavoritesPresenterProtocol?
    
    private let cellId = "favoritesTableViewCellId"
    
    private lazy var recipeTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadRecipe()
    }
}

//MARK: - Private methods
extension FavoritesViewController {
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"
    }
    
    private func configureTableView() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(recipeTableView)

        NSLayoutConstraint.activate([
            recipeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.recipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FavoritesTableViewCell
        
        if let isEmpty = presenter?.recipes.isEmpty {
            if !isEmpty {
                if let data = presenter?.recipes[indexPath.row] {
                    cell.setupCell(titile: data.title, image: data.recipeImage, ready: data.readyInMinutes)
                }
            }
        } else {
            cell.setupCell(titile: nil, image: nil, ready: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeRecipeFromFavorites(indexPath.row)
        }
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
   
}

extension FavoritesViewController: FavoritesViewProtocol {
    func updateView() {
        recipeTableView.reloadData()
    }
}
