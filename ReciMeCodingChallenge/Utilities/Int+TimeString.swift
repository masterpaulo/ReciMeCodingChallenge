//
//  Int+TimeString.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import Foundation

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
