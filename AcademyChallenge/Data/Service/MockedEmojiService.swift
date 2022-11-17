//
//  MockedEmojiService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 06/10/2022.
//

import UIKit
import RxSwift
class MockedEmojiService: EmojiService {
    private var mockedemojis: MockEmojis = .init()
    func fetchEmojis() -> Single<[Emoji]> {
        return Single.create { single in
            single(.success(self.mockedemojis.emojis))
            return Disposables.create { }
        }
    }
    
    func deleteEmoji(emojiToDelete: Emoji) {
        // mockedemojis.emojis
    }
}
