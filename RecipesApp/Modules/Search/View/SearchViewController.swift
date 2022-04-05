//
//  SearchViewController.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 31.03.2022.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {
    
    var presenter: SearchPresenter?
    
    private let cellId = "cellId"
    
    private lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search recipe: e.g. pasta"
        return searchBar
    }()
    
    private lazy var recipeTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(RecipeTableCell.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}

extension SearchViewController {
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.titleView = searchBar
    }
    
    private func configureTableView() {
        view.addSubview(recipeTableView)
        
        NSLayoutConstraint.activate([
            recipeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            presenter?.searchResipe(query: text)
        }
        searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.recipes.count ?? 0
    }
    
    #warning("обработка невалидного запроса! чтобы не крашнутся")
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RecipeTableCell
        
        if let isEmpty = presenter?.recipes.isEmpty {
            if !isEmpty {
                if let data = presenter?.recipes[indexPath.row] {
                    cell.setupCell(titile: data.title, image: data.image)
                }
            }
        } else {
            cell.setupCell(titile: nil, image: nil)
        }
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
}

//MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    
    func setSuccessSearchResult() {
        print(presenter?.recipes)
        recipeTableView.reloadData()
    }
    
    func setFailureSearchResult() {
        print("setFailureSearchResult")
    }
    
    func setWaiting() {
        print("setWaiting")
    }
    
}
