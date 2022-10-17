//
//  LiveAvatarStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import Foundation
import UIKit
import CoreData

class LiveAvatarStorage {
	
	private	var avatarNetwork: AvatarNetwork = .init()
	
	
	private let persistence: AvatarCoreData = .init()
	
	
	
	
	
	
		
	func fetchAvatarList(_ resultHandler: @escaping ([Avatar]) -> Void){
		
		persistence.fetch() { (result: [NSManagedObject]) in
			
			var avatars:[Avatar] = []
			
			if result.count != 0 {
				// TRANSFORM NSMANAGEDOBJECT ARRAY TO AVATAR ARRAY
				 avatars = result.map({ item in
					return item.ToAvatar()
				})
				
				
				
			}
			
			resultHandler(avatars)
		}
	}

	func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void){
		
		persistence.checkIfItemExist(searchText: searchText) { ( result: Result<[NSManagedObject], Error>) in
			switch result {
			case .success(let success):
				if success.count != 0 {
					
					guard let avatarFound = success.first else { return }
					
					resultHandler(.success(avatarFound.ToAvatar()))
				} else {
					// GET THE AVATAR FROM API
					let decoder = JSONDecoder()
					var request = URLRequest(url: URL(string: "https://api.github.com/users/\(searchText)")!)
					request.httpMethod = Method.get.rawValue

					let task = URLSession.shared.dataTask(with: request) { data, response, error in
						if let data = data {
							if let result = try? decoder.decode(Avatar.self, from: data) {
								self.persistence.persist(currentAvatar: result)
								resultHandler(.success(result))
							} else {
								resultHandler(.failure(APIError.unknownError))
							}
						} else if let error = error {
							resultHandler(.failure(error))
						}
					}

					task.resume()
				}
			case .failure(let failure):
				print("Failure to verify if avatar exists in Core data: \(failure)")
			}
		}
		
	}
	
	func deleteAvatar(avatarToDelete: Avatar, _ resultHandler: @escaping ([Avatar]) -> Void) {
		   
		   persistence.delete(avatarObject: avatarToDelete)
		   fetchAvatarList { (result: [Avatar]) in
			   resultHandler(result)
		   }
	   }
	
}

