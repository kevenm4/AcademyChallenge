//
//  LiveAvatarStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import Foundation
import UIKit
import CoreData

class LiveAvatarStorage: AvatarService {
	
	private	var avatarNetwork: AvatarNetwork = .init()
	
	
	private let persistence: AvatarCoreData = .init()
	
	
	
	
	
	
	func fetchAvatar(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void) {
		
		var fetchedAvatar : [NSManagedObject] = []
		fetchedAvatar = persistence.fetch()
		
		
//		if !fetchedAvatar.isEmpty {
//			let avatar = fetchedAvatar.map({ item in
//				return Avatar(login: item.value(forKey: "login") as! String,id: item.value(forKey: "id")as! Int, avatar_url: URL(string: item.value(forKey: "avatar_url") as! String)!)
//			})
//			print(avatar.count)
//			resultHandler(.success(avatar))
//
//		}else {
//			// METHOD IN EMOJI API
//				avatarNetwork.executeNetwork(AvatarAPI.getAvatar) { (result: Result<AvatarResponse, Error>) in
//					switch result{
//					case .success(let success):
//	//                    print("Success: \(success.emojis)")
//						resultHandler(.success(success.avatar))
//					case .failure(let failure):
//						print("Failure: \(failure)")
//						resultHandler(.failure(failure))
//					}
//				}
//		}
//	}
//
	
	
	
	
}
	
}
