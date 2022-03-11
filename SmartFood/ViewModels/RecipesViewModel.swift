//
//  RecipesViewModel.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import Foundation

class RecipesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var recipes = [Recipe]()
    
    let apiURL = "https://smartfood-api.azurewebsites.net/api"
    
    var decoder = JSONDecoder()
    
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
}
