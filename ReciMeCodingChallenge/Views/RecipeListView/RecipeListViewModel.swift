//
//  RecipeListViewModel.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation
import SwiftUI

class RecipeListViewModel: ObservableObject {
    
   // MARK: - Published Properites
    
    @Published var recipeList: [String] = (0...12).map{"Item \($0)"}
    
}
