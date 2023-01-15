//
//  RouteConfig.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation

import Foundation

/// HTTP Method typs (only the basics)
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - RouteConfig

protocol RouteConfig {
    typealias HeaderParams = [String: Any]
    typealias APIParams = [String: String]
    
    var method: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: HeaderParams { get }
    var params: APIParams { get }
    
    func asURLRequest() -> URLRequest?
}

extension RouteConfig {
    
    // a default extension that creates the full URL
    private var url: String {
        return baseURLString + path
    }
    
    var headers: HeaderParams {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    func asURLRequest() -> URLRequest? {
        var urlString = self.url
        if method == .get, !params.isEmpty {
            let urlComp = NSURLComponents(string: self.url)!
            var items = [URLQueryItem]()
            
            for (key,value) in params {
                items.append(URLQueryItem(name: key, value: value))
            }
            
            items = items.filter{!$0.name.isEmpty}
            
            if !items.isEmpty {
                urlComp.queryItems = items
            }
            urlString = urlComp.url!.absoluteString
        }
        
        // URL
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Header fields
        headers.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        
        return urlRequest
    }
}
