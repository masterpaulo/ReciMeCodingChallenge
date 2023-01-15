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
    
}

// MARK: - Network Connections

extension RecipeListViewModel {
    func loadRecipeList() {
        let userID = "7NWpTwiUWQMm89GS3zJW7Is3Pej1"
        requestLoader.getListOfRecipes(for: userID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                self.recipeList = list
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
