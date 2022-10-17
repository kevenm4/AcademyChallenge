//
//  ReposResponse.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation
import CoreData

//struct ReposResponse: Decodable {
//	
//	var repos: [Repos] = []
//	let persistence:ReposCoreData = ReposCoreData()
//	let user = "apple"
//	init(from decoder: Decoder) throws {
//		
//		let decoder = JSONDecoder()
//		var request = URLRequest(url: URL(string: "https://api.github.com/users/\(searchText)")!)
//		request.httpMethod = Method.get.rawValue
//
//		let task = URLSession.shared.dataTask(with: request) { data, response, error in
//			if let data = data {
//				if let result = try? decoder.decode(Avatar.self, from: data) {
//					self.persistence.persist(currentAvatar: result)
//					resultHandler(.success(result))
//			
//	}
//}
//		}
//		
//	}
//
//}
