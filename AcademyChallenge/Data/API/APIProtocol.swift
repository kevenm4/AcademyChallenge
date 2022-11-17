//
//  APIProtocol.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 19/10/2022.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
}

protocol APIProtocol {
    var url: URL { get }
    var method: Method { get }
    var headers: [String: String] { get }
}

enum APIError: Error {
    case unknownError
}
