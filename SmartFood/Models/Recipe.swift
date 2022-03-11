//
//  Recipe.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import Foundation

struct Recipe: Identifiable {
    let id: UUID
    let name: String
    let preparationTime: Int
    let servings: Int
    let ingredients: String
    let description: String
    let category: Category
    let photo: String
    let createdAt: Date
    let updatedAt: Date
}
