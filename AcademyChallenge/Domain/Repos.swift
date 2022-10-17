//
//  Repos.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation

import UIKit


struct Repos: Decodable {
	let full_name: String
	let id: Int
	let unique : Bool
	
	enum CodingKeys : String, CodingKey {
		case full_name
		case id
		case unique = "private"
		
	}
	
}

