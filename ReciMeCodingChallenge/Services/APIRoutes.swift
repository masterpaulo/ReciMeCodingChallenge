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
    
    
    var baseURLString: String {
        return AppConfig.API.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .recipeList: return .get
        }
    }
    
    var path: String {
        switch self {
        case .recipeList(let userId): return "profile/\(userId)/posts"
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
}
