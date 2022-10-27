//
//  EmojiListViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 27/10/2022.
//

import Foundation


class EmojiListViewModel {
	
	var emojiService: EmojiService?
	
	var arrEmojis: Box<[Emoji]?> = Box([])
	
	
	func getEmojis(){
		
		emojiService?.fetchEmojis({ [weak self] (result: Result<[Emoji],Error>) in
			switch result{
			case .success(let success):
				self?.arrEmojis.value = success
				self?.arrEmojis.value?.sort()
			case .failure(let failure):
				print("Failure: \(failure)")
			}
		})
}
	
	func deleteEM(emojis: Emoji) {
		
		self.emojiService?.deleteEmoji(emojiToDelete: emojis)
	}
}
