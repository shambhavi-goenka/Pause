//
//  Mood.swift
//  Despresso
//
//  Created by Shambhavi Goenka on 9/8/23.
//

import Foundation

enum Mood: String, Codable {
    case rain, cloud, sun, none
    
    var promptQuestion: String {
        switch self {
        case .rain:
            return "What would make you feel better on a sad day?"
        case .cloud:
            return "How can you make an OK day better?"
        case .sun:
            return "What made you happy today?"
        case .none:
            return "Create a new note"
        }
    }
}
