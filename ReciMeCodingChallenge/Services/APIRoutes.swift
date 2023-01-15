//
//  APIRoutes.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation


enum APIRoute: RouteConfig {
    
    // MARK: - API Routes
    case recipeList(userID: String)
    case recipeIngredients(recipeID: String)
    
    
    var baseURLString: String {
        return AppConfig.API.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .recipeList: return .get
        case .recipeIngredients: return .get
        }
    }
    
    var path: String {
        switch self {
        case .recipeList(let userID): return "profile/\(userID)/posts"
        case .recipeIngredients(let recipeID): return "recipe/\(recipeID)/ingredients"
        }
    }
    
    var params: APIParams {
        switch self {
        default: return [:]
        }
    }
    
}

// MARK: - Methods

extension RequestLoader {
    func getListOfRecipes(for userID: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        request(route: APIRoute.recipeList(userID: userID), completion: completion)
    }
    
    func getListOfIngredients(for recipeID: String, completion: @escaping (Result<IngredientList, Error>) -> Void) {
        request(route: APIRoute.recipeIngredients(recipeID: recipeID), completion: completion)
    }
}
