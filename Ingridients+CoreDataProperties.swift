//
//  Ingridients+CoreDataProperties.swift
//  RecipesApp
//
//  Created by Светлана Кривобородова on 10.04.2022.
//
//

import Foundation
import CoreData


extension Ingridients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingridients> {
        return NSFetchRequest<Ingridients>(entityName: "Ingridients")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var info: String?
    @NSManaged public var recipe: FavoriteRecipe?

}

extension Ingridients : Identifiable {

}
