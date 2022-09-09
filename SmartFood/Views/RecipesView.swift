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
    @State private var showConfirmation = false
    @State private var indexSetToDelete: IndexSet?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewmodel.recipes) { recipe in
                    RecipeView(recipe: recipe)
                }
                //.onDelete(perform: deleteRecipe)
                .onDelete { indexSet in
                    indexSetToDelete = indexSet
                    showConfirmation.toggle()
                }
                .confirmationDialog("Are you sure?", isPresented: $showConfirmation, titleVisibility: .visible) {
                    Button("Delete", role: .destructive) {
                        if let indexSetToDelete = indexSetToDelete {
                            deleteRecipe(at: indexSetToDelete)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .task {
                await fetchData()
            }
            .refreshable {
                await fetchData()
            }
            .toolbar {
                /*ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }*/
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
                    
    func deleteRecipe(at indexSet: IndexSet) {
        Task {
            do {
                try await viewmodel.deleteRecipe(at: indexSet)
            } catch {
                print("ERROR: \(error)")
            }
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
