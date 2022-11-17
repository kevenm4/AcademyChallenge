//
//  ReposAPI.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation
import UIKit

enum ReposAPI {
    case getRepos(perPage: Int, page: Int)
}
extension ReposAPI: APIProtocol {
    
    var method: Method {
        switch self {
        case .getRepos:
            return .get
        }
    }
    
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
    var url: URL {
        switch self {
        case .getRepos(let perPage, let page):
            var urlComponents = URLComponents(string: "\(Constants.baseURL)/users/apple/repos")
            urlComponents?.queryItems = [
                URLQueryItem(name: "per_page", value: String(perPage)),
                URLQueryItem(name: "page", value: String(page))
            ]
            guard let url = urlComponents?.url else {
                return URL(string: "")!
            }
            return url
        }
    }
}
