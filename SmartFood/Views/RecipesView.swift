//
//  RecipesView.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import SwiftUI

struct RecipesView: View {
    
    @State private var recipes = [Recipe](repeating: .preview, count: 10)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    RecipeView(recipe: recipe)
                }
                .navigationTitle("Recipes")
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipesView()
            
            RecipesView()
                .preferredColorScheme(.dark)
        }
    }
}
