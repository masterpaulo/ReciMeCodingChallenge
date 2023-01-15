//
//  RecipeDetailsViewModel.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation

class RecipeDetailsViewModel: BaseViewModel {
    
   // MARK: - Published Properites
    
    @Published var recipe: Recipe
    @Published var ingredientList: IngredientList?
    
    @Published var serveCount: Int
    
    // MARK: - init
    
    init(recipe: Recipe) {
        self.recipe = recipe
        serveCount = recipe.servingSize ?? 1
        
        super.init()
        loadRecipeIngredients()
    }
    
    // MARK: - Methods
    
    func incrementServeCount() {
        serveCount += 1
    }
    
    func decrementServeCount() {
        let newValue = serveCount - 1
        if newValue > 0 {
            serveCount = newValue
        }
    }
}

// MARK: - Display Properties

extension RecipeDetailsViewModel {
    var title: String { recipe.title }
    var author: String { "by \(recipe.creator.username)" }
    var prepTime: String { (recipe.prepTime ?? 0).minutesToTimeString }
    var cookTime: String { (recipe.cookTime ?? 0).minutesToTimeString }
    var difficulty: String { recipe.difficulty?.capitalized ?? " " }
    var imageURL: String { recipe.imageURL ?? "" }
    var description: String { recipe.desc ?? "" }
    
}

// MARK: - Network Connections

extension RecipeDetailsViewModel {
    func loadRecipeIngredients() {
        let recipeID = recipe.id
        loadingState = .loading
        requestLoader.getListOfIngredients(for: recipeID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.ingredientList = list
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
