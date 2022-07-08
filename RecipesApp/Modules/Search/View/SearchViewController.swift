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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureGestureToHideKeyboard()
    }
}

extension SearchViewController {
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.titleView = searchBar
    }
    
    private func configureTableView() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(recipeTableView)
        recipeTableView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            recipeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
        ])
    }
    
    private func configureGestureToHideKeyboard() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        recipeTableView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    private func handleTap() {
        searchBar.resignFirstResponder()
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
        cell.callbackForMoreButton = { [weak self] in
            guard let self = self else { return }
            self.presenter?.getDetailedRecipeInformation(from: indexPath.row)
        }
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        presenter?.getDetailedRecipeInformation(from: indexPath.row)
    }
}

//MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {

    func showSuccessSearchResult() {
        activityIndicator.stopAnimating()
        recipeTableView.reloadData()
    }
    
    func showFailureSearchResult() {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Invalid query", message: "Try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.searchBar.becomeFirstResponder()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showWaiting() {
        activityIndicator.startAnimating()
    }
    
    func showEmptyResult() {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Nothing found", message: "Try to refine your query", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.searchBar.becomeFirstResponder()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDetailedRecipeInformation(_ view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
