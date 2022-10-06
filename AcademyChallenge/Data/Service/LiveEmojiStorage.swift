//
//  LiveEmojiStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 29/09/2022.
//

import Foundation

class LiveEmojiStorage: EmojiStorage {
	private var emojiNetwork: EmojiNetwork = .init()
	var emojis: [Emoji] = []
	weak var delegate: EmojiStorageDelegate?
	
	init(){
		//getEmojisList()
	}
	
	
	func fetchEmojis(_ resultHandler: @escaping (EmojiResponse) -> Void) {
			emojiNetwork.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojiResponse, Error>) in
				switch result {
				case .success(let success):
					resultHandler(success)
	//                print("Success: \(success)")
				case .failure(let failure):
					print("Error: \(failure)")
				}
			}
		}
	
	func getRandomEmojiUrl(_ resultUrl: @escaping (URL) -> Void) {
		   // fetch emojis and return a random emoji
		   fetchEmojis { (result: EmojiResponse) in
			   guard let randomUrl = result.emojis.randomElement()?.imageUrl else { return }
			   
			   resultUrl(randomUrl)
		   }
	   }
		

}
