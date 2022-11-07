//
//  MainPageViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/10/2022.
//

import Foundation
import UIKit
//
import RxSwift
public class MainPagelViewModel {
    var application: Application?
	let emojiImage: Box<URL?> = Box(nil)
	let searchQuery: Box<String?> = Box(nil)
	var arrEmojis: Box<[Emoji]?> = Box([])
    let backgroundScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "MainPageViewModel.backgroundScheduler")

    private var rxEmojiImageUrl: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    private var _rxEmojiImage: BehaviorSubject<UIImage?> = BehaviorSubject(value: nil)
    var rxEmojiImage: Observable<UIImage?> { _rxEmojiImage.asObservable() }

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage?>] = [:]

	init() {

		searchQuery.bind { [weak self] _ in
			self?.saveAndSearchContent()
		}

//        rxEmojiImageUrl
//            .debug("rxEmojiImageUrl")
//            .flatMap ({ [weak self] url -> Observable<UIImage?> in
//                guard let self = self else {return Observable.never() }
//                var observable = self.ongoingRequests[url?.absoluteString ?? ""]
//
//                if observable == nil {
//                    self.ongoingRequests[url?.absoluteString ?? ""] = 
//                }
//            })
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
			case .failure(let failure):
				print("Failure: \(failure)")
			}
		})
}
}
