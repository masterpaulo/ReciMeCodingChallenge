//
//  Recipe.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation

struct Recipe: Decodable {
    var id: String
    var title: String
    var desc: String?
    var recipeURL: String?
    var imageURL: String?
    
    var creator: User
    
    var cookTime: Int?
    var prepTime: Int?
    
    var servingSize: Int?
    var difficulty: String?
    var method: String?
    
    var numSaves: Int?
    
    var tags: [String]
    
    private enum CodingKeys : String, CodingKey {
        case id
        case title
        case desc = "description"
        case recipeURL
        case imageURL
        case creator
        case cookTime
        case prepTime
        case servingSize
        case difficulty
        case method
        case numSaves
        case tags
    }
    
}

// MARK: Computed Properties

extension Recipe {
    var totalPrepAndCookTime: Int {
        (cookTime ?? 0) + (prepTime ?? 0)
    }
}
