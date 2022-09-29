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
	let url = URL(string: "https://api.github.com/emojis")!
	
	init(){
		loadEmojis()
	}
	
	func loadEmojis() {
		var request = URLRequest(url: url)

		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let data = data {
				let json = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String,String>
				if let array = json {
					for (emojiName,emojiUrl) in array {
						self.emojis.append(Emoji (name: "\(emojiName)", url: "\(emojiUrl)"))
					}
				}
				DispatchQueue.main.async {
					
					self.delegate?.emojiListUpdated()
				}
			} else if let error = error {
				print("HTTP Request Failed \(error)")
			}
		}

		task.resume()
	}
}
