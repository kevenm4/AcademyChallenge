//
//  MockEmojis.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/10/2022.
//

import Foundation

class MockEmojis: EmojiStorage {
	
	var emojis: [Emoji] = [Emoji(name: "caribbean_netherlands", imageUrl: URL(string: "https://github.githubassets.com/images/icons/emoji/unicode/1f1e7-1f1f6.png?v8")!),Emoji(name: "gear", imageUrl: URL(string: "https://github.githubassets.com/images/icons/emoji/unicode/2699.png?v8")!)]
	weak var delegate: EmojiStorageDelegate?
}
