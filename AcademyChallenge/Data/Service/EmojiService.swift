//
//  EmojiService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 06/10/2022.
//

import Foundation
 
protocol EmojiService: AnyObject {
	
	func fetchEmojis(_ resultHandler: @escaping (Result<[Emoji],Error>) -> Void)
	
	func deleteEmoji(emojiToDelete: Emoji)
		 
	
}
