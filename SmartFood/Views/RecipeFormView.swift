//
//  RecipeFormView.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-07-31.
//

import SwiftUI

struct RecipeFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewmodel: RecipesViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $viewmodel.recipe.name)
                }
                
                Section(header: Text("Preparation Time")) {
                    Stepper("\(viewmodel.recipe.preparationTime) min", value: $viewmodel.recipe.preparationTime, in: 1...100)
                }
                
                Section(header: Text("Servings")) {
                    Stepper("\(viewmodel.recipe.servings) persons", value: $viewmodel.recipe.servings, in: 1...12)
                }
                
                Picker("Category", selection: $viewmodel.recipe.category) {
                    ForEach(viewmodel.categories) { category in
                        Text(category.name)
                            .tag(category)
                    }
                }
                .pickerStyle(.automatic)
                
                Section(header: Text("Description")) {
                    TextField("Description", text: $viewmodel.recipe.description)
                }
                
                Section(header: Text("Ingredients")) {
                    TextField("Ingredients", text: $viewmodel.recipe.ingredients)
                }
            }
            .navigationTitle("Add Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                    }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: save) {
                        Text("Done")
                    }
                }
            }
            .task {
                await fetchData()
            }
        }
    }
}

extension RecipeFormView {
    func fetchData() async {
        do {
            try await viewmodel.fetchCategories()
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    func save() {
        Task {
            do {
                try await viewmodel.postRecipe()
                dismiss()
            } catch {
                print("ERROR: \(error)")
            }
        }
    }
}

struct RecipeFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeFormView()
            
            RecipeFormView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(RecipesViewModel())
    }
}
