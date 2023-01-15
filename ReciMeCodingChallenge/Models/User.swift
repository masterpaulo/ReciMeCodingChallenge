//
//  User.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation

struct User: Decodable {
    let uid: String
    var username: String
    var prfileImageUrl: String?
    var firstname: String?
    var lastname: String?
    
    private enum CodingKeys : String, CodingKey {
        case uid
        case username
        case prfileImageUrl
        case firstname
        case lastname
    }
}
