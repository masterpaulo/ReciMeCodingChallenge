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
    @Published var ingredientList: [IngredientItemType] = []
    
    @Published var serveCount: Int
    
    let defaultServeCount: Int
    
    var multiplier: Double {
        Double(serveCount) / Double(defaultServeCount)
    }
    
    // MARK: - init
    
    init(recipe: Recipe) {
        self.recipe = recipe
        let serveCount = recipe.servingSize ?? 1
        self.serveCount = serveCount
        defaultServeCount = serveCount
        
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
    var authorImageURL: String { recipe.creator.profileImageUrl ?? "" }
    var prepTime: String { (recipe.prepTime ?? 0).minutesToTimeString }
    var cookTime: String { (recipe.cookTime ?? 0).minutesToTimeString }
    var difficulty: String { recipe.difficulty?.capitalized ?? " " }
    var imageURL: String { recipe.imageURL ?? "" }
    var description: String { recipe.desc ?? "" }
    
    var methodItems: [MethodItemViewModel] {
        
        guard let methodsString = recipe.method else { return [] }
        
        let lines = methodsString.split(separator: "\n")
        
        var methods = [MethodItemViewModel]()
        
        var lastIndexOfHeaderLine: Int = -1
        
        for (index, line) in lines.enumerated() {
            if line.hasPrefix("##") {
                lastIndexOfHeaderLine = index
                let stepNumber = index - lastIndexOfHeaderLine
                let text = line.dropFirst(2).trimmingCharacters(in: .whitespacesAndNewlines)
                
                methods.append(MethodItemViewModel(step: stepNumber, text: text))
            } else {
                let stepNumber = index - lastIndexOfHeaderLine
                let text = String(line)
                methods.append(MethodItemViewModel(step: stepNumber, text: text))
            }
            
        }
        return methods
    }
}

/// step - indicates a numerical value of what step the line is based on order; if step is zero (0), display text as a header
/// text - the string value to display the details of the header title
class MethodItemViewModel: Identifiable {
    let id = UUID()
    let step: Int
    let text: String
    
    init(step: Int, text: String) {
        self.step = step
        self.text = text
    }
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
                    self.ingredientList = list.list
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
