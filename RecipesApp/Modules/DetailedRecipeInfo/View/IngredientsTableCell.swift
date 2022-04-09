//
//  IngredientsTableCell.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 10.04.2022.
//

import Foundation
import UIKit

final class IngredientsTableCell: UITableViewCell {

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(title: String?, image: UIImage?) {
        self.title.text = title
        ingredientImageView.image = image
    }
}

extension IngredientsTableCell {
    private func configureCell() {
        contentView.addSubviews([
            title,
            ingredientImageView,
        ])
        
        NSLayoutConstraint.activate([
            ingredientImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            ingredientImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientImageView.heightAnchor.constraint(equalToConstant: 80),
            ingredientImageView.widthAnchor.constraint(equalToConstant: 80),
            ingredientImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            title.leadingAnchor.constraint(equalTo: ingredientImageView.trailingAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: ingredientImageView.topAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}

