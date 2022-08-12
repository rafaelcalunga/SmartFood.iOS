//
//  Recipe.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id: UUID
    var name: String
    var preparationTime: Int
    var servings: Int
    var ingredients: String
    var description: String
    var category: Category
    var photo: String
    //let createdAt: Date
    //let updatedAt: Date
    
    static var newRecipe = Recipe(
        id: UUID(),
        name: "",
        preparationTime: 0,
        servings: 0,
        ingredients: "",
        description: "",
        category: Category(id: UUID(), name: ""),
        photo: "https://picsum.photos/400/300"
    )
}
