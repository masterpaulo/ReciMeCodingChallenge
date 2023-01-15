//
//  RequestLoader.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation

class RequestLoader {
    
    /// Perform API requests with a given route
    ///
    /// - Parameters:
    ///   - route: A RouteConfig value describing the API resource
    func request<T: Decodable>(route: RouteConfig, completion: @escaping (Result<T, Error>)->Void) {

        let session = URLSession.shared

        let urlRequest = route.asURLRequest()!
        
        print(urlRequest.curlString) // for debugging
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(object))
            }
            catch let err {
                completion(.failure(err))
            }
        }

        task.resume()
    }
}

extension URLRequest {

    /**
     Returns a cURL command representation of this URL request.
     */
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

}
