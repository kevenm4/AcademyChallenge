//
//  LiveAvatarStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import Foundation


class LiveAvatarStorage: AvatarStorage {
	
	private var avatarNetwork: AvatarNetwork = .init()
	var avatar: [Avatar] = []
	weak var delegates: AvatarStorageDelegate?
	
	init(){
		getAvatarList()
	}
	
	func getAvatarList () {
		
		avatarNetwork.executeNetwork(AvatarAPI.getAvatar) { (result: Result<[Avatar], Error>) in
			switch result {
			case .success(let success):
					self.avatar = success
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
