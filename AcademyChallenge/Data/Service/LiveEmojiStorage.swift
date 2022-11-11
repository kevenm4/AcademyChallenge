//
//  LiveEmojiStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 29/09/2022.
//

import Foundation
import CoreData
import RxSwift
class LiveEmojiStorage: EmojiService {

    private var emojiNetwork: Network = .init()

    private let emojiPersistence: EmojiCoreData

    init(persistentContainer: NSPersistentContainer) {
        emojiPersistence = EmojiCoreData(persistentContainer: persistentContainer)
    }

    func persistEmjis(emojis: [Emoji]) {
        emojis.forEach { emoji in
            emojiPersistence.persist(name: emoji.name, imageUrl: emoji.imageUrl.absoluteString)
        }
    }

    func fetchEmojis (_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {

        var fetchedEmojis: [Emoji] = []
        fetchedEmojis = emojiPersistence.fetch()

        if !fetchedEmojis.isEmpty {
            resultHandler(.success(fetchedEmojis))

        } else {
            // METHOD IN EMOJI API
            emojiNetwork.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result<EmojiResponse, Error>) in
                switch result {
                case .success(let success):
                    self.persistEmjis(emojis: success.emojis)
                    resultHandler(.success(success.emojis))
                case .failure(let failure):
                    print("Failure: \(failure)")

                    resultHandler(.failure(failure))
                }
            }

        }

    }

    func rxGetEmojisList() -> Single<[Emoji]> {
        // SUBSCRIBE DESTROI OS OBSERVABLES
        // SUBSCRIBE APENAS DEVE HAVER NO FIM
        // DO() SÓ ESTAMOS A ACRESCENTAR UM EVENTO (SIDE EFFECT) AO OBSERVABLE
        // DO() NÃO TERMINA O FLUXO DO OBSERVABLE
        return emojiNetwork.rxExecuteNetworkCall(EmojiAPI.getEmojis)
            .map { (emojisResult: EmojiResponse) in
                    return emojisResult.emojis
                }

    }

    func deleteEmoji(emojiToDelete: Emoji) {

        emojiPersistence.delete(emojiObject: emojiToDelete)
    }

}
