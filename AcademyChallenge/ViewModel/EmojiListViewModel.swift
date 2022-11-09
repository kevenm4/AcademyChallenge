//
//  EmojiListViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 27/10/2022.
//

import Foundation
import UIKit
//
import RxSwift

class EmojiListViewModel {
    	var emojiService: EmojiService?
    	var arrEmojis: Box<[Emoji]?> = Box([])

    let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage>] = [:]

    func imageAtUrl(url: URL) -> Observable<UIImage> {
        Observable<UIImage>
            .deferred { [weak self] in
                guard let self = self else { return Observable.never() }
                let observable = self.ongoingRequests[url.absoluteString]

                // Verifica se o url já foi guardado no ongoingRequests
                if observable == nil {
                    self.ongoingRequests[url.absoluteString] = self.dataOfUrl(url)
                }

                guard let observable = self.ongoingRequests[url.absoluteString] else { return Observable.never() }

                return observable
            }
            .subscribe(on: MainScheduler.instance)
    }

    func dataOfUrl(_ url: URL?) -> Observable<UIImage> {
        Observable<URL?>.never().startWith(url)
            .observe(on: backgroundScheduler)
            .flatMapLatest { url throws -> Observable<UIImage> in
                guard let url = url else { return Observable.just(UIImage()) }
                return downloadTask(url: url)
            }
            .share(replay: 1, scope: .forever)
            .observe(on: MainScheduler.instance)
    }

    func getEmojis() {
        emojiService?.fetchEmojis({ [weak self] (result: Result<[Emoji], Error>) in
            switch result {
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
