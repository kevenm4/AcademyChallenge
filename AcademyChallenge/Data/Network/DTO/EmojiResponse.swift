//
//  EmojiResponse.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/10/2022.
//

import Foundation
import CoreData


struct EmojiResponse: Decodable {
	
	var emojis: [Emoji] = []
	//let persistence: EmojiCoreData = EmojiCoreData()
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.singleValueContainer()
		
		let emojisAsDictionary = try container.decode([String: String].self)
		
		emojis = emojisAsDictionary.map ({ (key: String, value: String) in
		//	persistence.persist(name: key, imageUrl: value)
			
			 Emoji(name: key, imageUrl: URL(string: value)!)
			
		})
	}
}



