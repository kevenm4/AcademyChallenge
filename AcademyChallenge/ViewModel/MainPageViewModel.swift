//
//  MainPageViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/10/2022.
//

import Foundation

public class MainPageViewModel {
	var emojiService: EmojiService?
	var avatarService: LiveAvatarStorage?
	
	let emojiImage: Box<URL?> = Box(nil)
	let searchQuery: Box<String?> = Box(nil)
	
	init(emojiService: EmojiService, avatarService: LiveAvatarStorage) {
		self.emojiService = emojiService
		self.avatarService = avatarService
		
		searchQuery.bind { [weak self] searchQuery in
			self?.saveAndSearchContent()
		}
	}
	
	func getRandom(){
		emojiService?.fetchEmojis({ [weak self] (result: Result<[Emoji],Error>) in
			switch result{
			case .success(let success):
				guard let randomUrl = success.randomElement()?.imageUrl else { return }
				self?.emojiImage.value = randomUrl
			case .failure(let failure):
				print("Failure: \(failure)")

			}
			
		})
	}
	
	private func saveAndSearchContent() {
		guard let searchQuery = searchQuery.value else { return }
		avatarService?.getAvatar(searchText: searchQuery, { (result: Result<Avatar, Error>) in
			switch result {
			case .success(let success):
				let avatarUrl = success.avatarUrl
				self.emojiImage.value = avatarUrl
			case .failure(let failure):
				print("Failure to Get Avatar: \(failure)")
				self.emojiImage.value = nil
			}
		})
	}
}
