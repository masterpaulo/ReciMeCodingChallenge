//
//  Ingredient.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation


struct IngredientList: Decodable {
    var list: [IngredientItemType]
    
    init(from decoder: Decoder) throws {
        let list = try decoder.singleValueContainer().decode([IngredientItemType].self)
        self.list = list
    }
}

enum IngredientItemType: Decodable {
    case header(title: String)
    case ingredient(ingredient: Ingredient)
    
    enum CodingKeys: String, CodingKey {
        case header = "heading"
        case ingredient
    }
    
    enum HeaderCodingKeys: CodingKey {
        case title
    }
    
    enum IngredientCodingKeys: CodingKey {
        case ingredient
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch container.allKeys.first {
        case .header:
            // If JSON object contains `header` attribute, decode it as a Header item
            let title = try container.decode(String.self, forKey: .header)
            self = IngredientItemType.header(title: title)
        default:
            // else, decode it as a regular Ingredient item
            let ingredient = try decoder.singleValueContainer().decode(Ingredient.self)
            self = IngredientItemType.ingredient(ingredient: ingredient)
        }
    }
}

struct Ingredient: Decodable {
    var id: Int?
    var product: String?
    var quantity: Double?
    var unit: String?
    var productModifier: String?
    var preparationNotes: String?
    var imageFileName: String?
    var rawText: String?
    var rawProduct: String?
    var measurement: Measurement?
    
    private enum CodingKeys : String, CodingKey {
        case id
        case product
        case quantity
        case unit
        case productModifier
        case preparationNotes
        case imageFileName
        case rawText
        case rawProduct
        case measurement
    }
    
}

struct Measurement: Decodable {
    var measurement: String
    var sys: String
    var category: String
    var plural: String
}
