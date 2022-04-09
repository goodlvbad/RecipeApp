//
//  RecipeTableCell.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 02.04.2022.
//

import Foundation
import UIKit

final class RecipeTableCell: UITableViewCell {
    
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
    
    private lazy var recipeCalories: UILabel = {
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
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.4
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(titile: String?, image: UIImage?) {
        recipeTitle.text = titile
        recipeImageView.image = image
    }
}

extension RecipeTableCell {
    private func configureCell() {
        contentView.addSubviews([
            recipeImageView,
            recipeTitle,
            moreButton,
        ])
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 80),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80),
            recipeImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            recipeTitle.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            recipeTitle.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            recipeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            moreButton.heightAnchor.constraint(equalToConstant: 25),
            moreButton.widthAnchor.constraint(equalToConstant: 65),
            moreButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    @objc
    private func moreButtonTapped(_ sender: UIButton) {
        callbackForMoreButton?()
    }
}
