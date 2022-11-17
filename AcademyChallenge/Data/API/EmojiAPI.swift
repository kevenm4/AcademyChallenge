//
//  EmojiAPI.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/10/2022.
//

import Foundation

enum EmojiAPI {
    case getEmojis
    case postEmoji
}

extension EmojiAPI: APIProtocol {
    
    var url: URL {
        URL(string: "\(Constants.baseURL)/emojis")!
    }
    
    var method: Method {
        switch self {
        case .getEmojis:
            return .get
        case .postEmoji:
            return .post
        }
    }
    
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}
