//
//  RecipeView.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import SwiftUI

struct RecipeView: View {
    
    var recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.photo)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                
                VStack(alignment: .leading) {
                    Label("\(recipe.preparationTime) min", systemImage: "clock")
                    Label("\(recipe.servings) persons", systemImage: "fork.knife")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.vertical, 1)
                
                Text(recipe.category.name)
                    .font(.system(size: 14))
                    .padding(.horizontal, 10)
                    .background(.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeView(recipe: .preview)
            
            RecipeView(recipe: .preview)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
