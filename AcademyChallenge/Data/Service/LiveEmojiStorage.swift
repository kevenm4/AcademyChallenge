//
//  LiveEmojiStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 29/09/2022.
//

import Foundation

class LiveEmojiStorage: EmojiService {

	private var emojiNetwork: EmojiNetwork = .init()
	
	
	
	func fetchEmojis(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
		emojiNetwork.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojiResponse, Error>) in
			switch result {
			case .success(let success):
				resultHandler(.success(success.emojis))
//                print("Success: \(success)")
			case .failure(let failure):
				print("Error: \(failure)")
			}
		}
	}
	


}

