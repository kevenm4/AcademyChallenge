//
//  ReposAPI.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation
import UIKit


enum ReposAPI {
	case getRepos
	case postRepos
}

let user = "apple"

extension ReposAPI: APIProtocol{
	

	
	var url: URL {
		
		URL(string: "https://api.github.com/users/\(user)/repos")!
	}
	
	var method: Method {
		switch self {
		case .getRepos:
			return .get
		case .postRepos:
			return .post
		}
	}
	
	var headers: [String : String] {
		["Content-Type": "application/json"]
	}
	
	
}
