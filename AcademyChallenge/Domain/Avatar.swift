//
//  Avatar.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//
import UIKit
import Foundation

struct Avatar: Decodable {
    
    let login: String
    let id: Int
    let avatarUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        
    }
}
