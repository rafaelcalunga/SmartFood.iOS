//
//  RecipesViewModel.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import Foundation

enum NetworkError: Error {
    case serverError
}

class RecipesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var recipes = [Recipe]()
    @Published var categories = [Category]()
    @Published var recipe = Recipe.newRecipe
    
    let apiURL = "https://smartfood-api.azurewebsites.net/api"
    
    var decoder = JSONDecoder()
    var encoder = JSONEncoder()
    
    // MARK: - Methods
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    @MainActor func fetchRecipes() async throws {
        print("LOG: fetchRecipes...")
        let url = URL(string: "\(apiURL)/recipes")!
        let (data, _) = try await URLSession.shared.data(from: url)
        recipes = try decoder.decode([Recipe].self, from: data)
    }
    
    @MainActor func fetchCategories() async throws {
        print("LOG: fetchCategories...")
        let url = URL(string: "\(apiURL)/categories")!
        let (data, _) = try await URLSession.shared.data(from: url)
        categories = try decoder.decode([Category].self, from: data)
    }
    
    @MainActor func postRecipe() async throws {
        print("LOG: postRecipe...", recipe)
        let url = URL(string: "\(apiURL)/recipes")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try encoder.encode(recipe)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 201 else {
            throw NetworkError.serverError
        }
        
        let createdRecipe = try decoder.decode(Recipe.self, from: data)
        recipes.append(createdRecipe)
    }
}
