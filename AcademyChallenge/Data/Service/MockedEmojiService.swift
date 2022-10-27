//
//  MockedEmojiService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 06/10/2022.
//

import UIKit

class MockedEmojiService: EmojiService {

	private var mockedemojis: MockEmojis = .init()

	func fetchEmojis(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
		resultHandler(.success(mockedemojis.emojis))
	}

	func deleteEmoji(emojiToDelete: Emoji) {
		mockedemojis.emojis
	}
}
