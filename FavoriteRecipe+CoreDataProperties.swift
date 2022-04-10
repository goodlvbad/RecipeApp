//
//  FavoriteRecipe+CoreDataProperties.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 10.04.2022.
//
//

import Foundation
import CoreData


extension FavoriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteRecipe> {
        return NSFetchRequest<FavoriteRecipe>(entityName: "FavoriteRecipe")
    }

    @NSManaged public var id: Int64
    @NSManaged public var titile: String?
    @NSManaged public var recipeInfo: String?
    @NSManaged public var readyInMinutes: String?
    @NSManaged public var image: String?
    @NSManaged public var ingridients: NSSet?

}

// MARK: Generated accessors for ingridients
extension FavoriteRecipe {

    @objc(addIngridientsObject:)
    @NSManaged public func addToIngridients(_ value: Ingridients)

    @objc(removeIngridientsObject:)
    @NSManaged public func removeFromIngridients(_ value: Ingridients)

    @objc(addIngridients:)
    @NSManaged public func addToIngridients(_ values: NSSet)

    @objc(removeIngridients:)
    @NSManaged public func removeFromIngridients(_ values: NSSet)

}

extension FavoriteRecipe : Identifiable {

}
