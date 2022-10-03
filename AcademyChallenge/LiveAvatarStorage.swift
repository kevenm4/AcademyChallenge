//
//  LiveAvatarStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import Foundation


class LiveAvatarStorage: AvatarStorage {
	
	
	var avatar: [Avatar] = []
	weak var delegates: AvatarStorageDelegate?
	
	init(){
		getAvatarList()
	}
	
	func getAvatarList () {
		
		executeNetworkCall(AvatarAPI.getAvatar) { (result: Result<AvatarAPICALLRESULT, Error>) in
			switch result {
			case .success(let success):
					self.avatar = success.avatar
				DispatchQueue.main.async {
								   self.delegates?.avatarListUpdate()
							   }
				print("Success: \(success)")
			case .failure(let failure):
				print("Error: \(failure)")
			}
		}

	}

}
