//
//  RecipeStepsView.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 10.04.2022.
//

import Foundation
import UIKit

final class RecipeStepsView: UIView {
    
    private lazy var recipeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recipeInfo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recipeReadyTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recipeServings: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setRecipeInfo(title: String, text: String, ready: String, servings: String) {
        recipeTitle.text = title
        recipeInfo.text = text
        recipeReadyTime.text = "Ready in minutes: " + ready
        recipeServings.text = "Servings: " + servings
    }
}

extension RecipeStepsView {
    private func setupView() {
        backgroundColor = .red
        addSubviews([
            recipeTitle,
            recipeReadyTime,
            recipeServings,
            recipeInfo,
        ])
        
        NSLayoutConstraint.activate([
            recipeTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            recipeTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            recipeServings.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 10),
            recipeServings.trailingAnchor.constraint(equalTo: recipeTitle.trailingAnchor),
            
            recipeReadyTime.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 10),
            recipeReadyTime.leadingAnchor.constraint(equalTo: recipeTitle.leadingAnchor),
            recipeReadyTime.trailingAnchor.constraint(equalTo: recipeServings.leadingAnchor, constant: -10),
            recipeReadyTime.widthAnchor.constraint(equalTo: recipeServings.widthAnchor),
            
            recipeInfo.topAnchor.constraint(equalTo: recipeReadyTime.bottomAnchor, constant: 10),
            recipeInfo.trailingAnchor.constraint(equalTo: recipeTitle.trailingAnchor),
            recipeInfo.leadingAnchor.constraint(equalTo: recipeTitle.leadingAnchor),
            recipeInfo.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            
            
        ])
    }
}

