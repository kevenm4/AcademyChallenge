//
//  LiveEmojiStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 29/09/2022.
//

import Foundation

class LiveEmojiStorage: EmojiStorage {
	
	var emojis: [Emoji] = []
	weak var delegate: EmojiStorageDelegate?
	
	init(){
		getEmojisList()
	}
	
	
	func getEmojisList() {
		
		executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojisAPICAllResult, Error>) in
			switch result {
				
			case .success(let success):
					self.emojis = success.emojis
				self.emojis.sort()
				DispatchQueue.main.async {
								   self.delegate?.emojiListUpdated()
							   }
				print("Success: \(success)")
			case .failure(let failure):
				print("Error: \(failure)")
			}
		}
		
	}

}
