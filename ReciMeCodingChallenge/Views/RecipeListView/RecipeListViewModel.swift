//
//  RecipeListViewModel.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation
import SwiftUI

class RecipeListViewModel: BaseViewModel {
    
   // MARK: - Published Properites
    
    @Published var recipeList: [Recipe] = []
    @Published var selectedRecipe: Recipe?
    
}

// MARK: - Network Connections

extension RecipeListViewModel {
    func loadRecipeList() {
        let userID = AppConfig.userID
        loadingState = .loading
        requestLoader.getListOfRecipes(for: userID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.recipeList = list
                    self.loadingState = .loaded
                }
            case .failure(let error):
                debugPrint(error)
                DispatchQueue.main.async {
                    self.loadingState = .error
                }
            }
        }
    }
}
