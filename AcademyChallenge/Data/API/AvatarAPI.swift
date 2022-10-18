//
//  AvatarAPI.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/10/2022.
//

import Foundation

enum AvatarAPI {
	case getAvatar
	case postAvatar
}


extension AvatarAPI: APIProtocol{
	var url: URL {
		URL(string: "https://api.github.com/users")!
	}
	
	var method: Method {
		switch self {
		case .getAvatar:
			return .get
		case .postAvatar:
			return .post
		}
	}
	
	var headers: [String : String] {
		["Content-Type": "application/json"]
	}
	
	
}
