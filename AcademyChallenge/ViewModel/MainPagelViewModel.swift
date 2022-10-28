//
//  MainPageViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/10/2022.
//

import Foundation

public class MainPagelViewModel {
    var application: Application?
	let emojiImage: Box<URL?> = Box(nil)
	let searchQuery: Box<String?> = Box(nil)
	var arrEmojis: Box<[Emoji]?> = Box([])

	init() {

		searchQuery.bind { [weak self] _ in
			self?.saveAndSearchContent()
		}

	}

	func getRandom() {

        application?.emojiSource.fetchEmojis({ [weak self] (result: Result<[Emoji], Error>) in
			switch result {
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
        application?.avatarService.getAvatar(searchText: searchQuery, { (result: Result<Avatar, Error>) in
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

	func getEmojis() {

        application?.emojiSource.fetchEmojis({ [weak self] (result: Result<[Emoji], Error>) in
			switch result {
			case .success(let success):
				self?.arrEmojis.value = success
				self?.arrEmojis.value?.sort()
				DispatchQueue.main.async { [weak self] in
					// self?.collectionView.reloadData()
				}
			case .failure(let failure):
				print("Failure: \(failure)")
			}
		})
}
}
