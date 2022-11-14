//
//  EmojiService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 06/10/2022.
//

import Foundation
import RxSwift

protocol EmojiService: AnyObject {

	func fetchEmojis() -> Single<[Emoji]>

	func deleteEmoji(emojiToDelete: Emoji)

}
