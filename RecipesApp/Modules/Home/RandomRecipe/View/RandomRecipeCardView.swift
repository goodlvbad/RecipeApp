//
//  RecipeCardView.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 01.04.2022.
//

import Foundation
import UIKit

final class RandomRecipeCardView: UIView {
    
    var callbackForMoreButton: (() -> Void)?
    
    private lazy var recipeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var recipeReadyTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var recipeDishType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(moreButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setRecipeMinimalInfo(title: String, ready: String?, dishType: [String], image: UIImage?) {
        recipeTitle.text = title
        recipeImageView.image = image
        if let ready = ready {
            recipeReadyTime.text = "Ready in minutes: " + ready
        } else {
            recipeReadyTime.text = ""
        }
        if dishType.isEmpty {
            recipeDishType.text = ""
        } else {
            recipeDishType.text = dishType[0]
        }
    }
}

extension RandomRecipeCardView {
    private func setupView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
        addSubviews([
            recipeTitle,
            recipeImageView,
            recipeReadyTime,
            recipeDishType,
            moreButton
        ])
        
        NSLayoutConstraint.activate([
            recipeTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            recipeTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            recipeImageView.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 80),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80),
            
            recipeReadyTime.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            recipeReadyTime.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20),
            recipeReadyTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            recipeDishType.topAnchor.constraint(equalTo: recipeReadyTime.bottomAnchor, constant: 10),
            recipeDishType.leadingAnchor.constraint(equalTo: recipeReadyTime.leadingAnchor),
            recipeDishType.trailingAnchor.constraint(equalTo: recipeReadyTime.trailingAnchor),
            
            moreButton.topAnchor.constraint(equalTo: recipeDishType.bottomAnchor, constant: 10),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            moreButton.heightAnchor.constraint(equalToConstant: 40),
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
        ])
    }
    
    @objc
    private func moreButtonTapped(_ sender: UIButton) {
//        callbackForMoreButton
    }
}
