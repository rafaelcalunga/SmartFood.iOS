//
//  MockedViewModel.swift
//  SmartFood
//
//  Created by Rafael Calunga on 2022-03-11.
//

import Foundation

extension RecipesViewModel {
    static func fullState() -> RecipesViewModel {
        let vm = RecipesViewModel()
        vm.recipes = [Recipe](repeating: .preview, count: 10)
        return vm
    }
}
