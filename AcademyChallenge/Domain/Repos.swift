//
//  Repos.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation

import UIKit


struct Repos: Decodable {
	let id: Int
	let fullName: String
	let unique : Bool
	
	enum CodingKeys : String, CodingKey {
		case fullName = "full_name"
		case id
		case unique = "private"
		
	}
	
}

