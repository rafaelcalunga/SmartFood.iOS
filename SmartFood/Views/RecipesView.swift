//
//  RecipesView.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import SwiftUI

struct RecipesView: View {
    @StateObject var viewmodel = RecipesViewModel()
    @State private var showAddForm = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewmodel.recipes) { recipe in
                    RecipeView(recipe: recipe)
                }
                .navigationTitle("Recipes")
            }
            .task {
                await fetchData()
            }
            .refreshable {
                await fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: openForm) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddForm) {
                RecipeFormView()
                    .environmentObject(viewmodel)
            }
        }
    }
}

extension RecipesView {
    func openForm() {
        viewmodel.recipe = Recipe.newRecipe
        showAddForm.toggle()
    }
    
    func fetchData() async {
        do {
            try await viewmodel.fetchRecipes()
        } catch {
            print("ERROR: \(error)")
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipesView(viewmodel: RecipesViewModel.fullState())
            
            RecipesView(viewmodel: RecipesViewModel.fullState())
                .preferredColorScheme(.dark)
        }
    }
}
