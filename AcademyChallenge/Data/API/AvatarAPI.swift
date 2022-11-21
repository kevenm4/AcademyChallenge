//
//  AvatarAPI.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/10/2022.
//

import Foundation

enum AvatarAPI {
    case getAvatar(String)
    // case postAvatar
}

extension AvatarAPI: APIProtocol {
    var method: Method {
        switch self {
        case .getAvatar:
            return .get
        }
    }
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
    var url: URL {
        switch self {
        case .getAvatar(let name):
            return URL(string: "\(Constants.baseURL)/users/\(name)")!
        }
    }
}
