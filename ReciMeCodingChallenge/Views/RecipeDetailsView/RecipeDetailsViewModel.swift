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
    
    @Published var serveCount: Int
    
    // MARK: - init
    
    init(recipe: Recipe) {
        self.recipe = recipe
        serveCount = recipe.servingSize ?? 1
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


// TODO: Put in a Utility file
extension Int {
    var minutesToTimeString: String {
        let hours = self / 60
        let minutes = self % 60
        
        var text = ""
        
        if hours > 0 {
            text += "\(hours)h "
        }
        
        text += "\(minutes)m"
        
        return text
    }
}
