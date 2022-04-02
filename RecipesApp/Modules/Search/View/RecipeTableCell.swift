//
//  RecipeTableCell.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 02.04.2022.
//

import Foundation
import UIKit

final class RecipeTableCell: UITableViewCell {
    
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
    
    private lazy var recipeCalories: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(titile: String?, image: UIImage?) {
        recipeTitle.text = titile
        if image == nil {
            recipeImageView.isHidden = true
        } else {
//            recipeImageView.isHidden = false
            recipeImageView.image = image
        }
    }
}

extension RecipeTableCell {
    private func configureCell() {
        contentView.addSubviews([
            recipeImageView,
            recipeTitle,
        ])
        
        let leadingConstraintWithImage = recipeTitle.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10)
        let leadingConstraintWithoutImage = recipeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 60),
            recipeImageView.widthAnchor.constraint(equalToConstant: 60),
            recipeImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            
//            recipeImageView.image == nil ? leadingConstraintWithoutImage: leadingConstraintWithImage,
            leadingConstraintWithImage,
            recipeTitle.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            recipeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeTitle.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),

//            recipeCalories.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 10),
//            recipeCalories.leadingAnchor.constraint(equalTo: recipeTitle.leadingAnchor),
//            recipeCalories.trailingAnchor.constraint(equalTo: recipeTitle.trailingAnchor),
//            recipeCalories.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}
