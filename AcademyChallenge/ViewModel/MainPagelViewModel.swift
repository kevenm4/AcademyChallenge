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
    var application: Application
    //   let emojiImage: Box<URL?> = Box(nil)
//    let searchQuery: Box<String?> = Box(nil)
//    var arrEmojis: Box<[Emoji]?> = Box([])
    let backgroundScheduler = SerialDispatchQueueScheduler(internalSerialQueueName:
                                                            "MainPageViewModel.backgroundScheduler")

    private var rxEmojiImageUrl: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    private var _rxEmojiImage: BehaviorSubject<UIImage?> = BehaviorSubject(value: nil)
    var rxEmojiImage: Observable<UIImage?> { _rxEmojiImage.asObservable() }

    private var searchAvatarName: PublishSubject<String> = PublishSubject()
       private var _searchAvatar: PublishSubject<UIImage?> = PublishSubject()
       var searchAvatar: Observable<UIImage?> { _searchAvatar.asObservable() }

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage?>] = [:]

    init(application: Application) {
        self.application = application

//        searchQuery.bind { [weak self] _ in
//            self?.saveAndSearchContent()
//        }
        rxEmojiImageUrl
            .debug("rxEmojiImageUrl")
            .flatMap({ [weak self] url -> Observable<UIImage?> in
                guard let self = self else { return Observable.never() }

                let observable = self.ongoingRequests[url?.absoluteString ?? ""]

                // Verifica se o url já foi guardado no ongoingRequests
                if observable == nil {
                    self.ongoingRequests[url?.absoluteString ?? ""] = self.dataOfUrl(url).share(replay: 1,
                                                                                                scope: .forever)
                }

                guard let observable = self.ongoingRequests[url?.absoluteString ?? ""]
                else {
                    return Observable.never()

                }

                return observable
            })
            .debug("rxEmojiImage")
            .subscribe(_rxEmojiImage)
            .disposed(by: disposeBag)

        searchAvatarName
                   .debug("rxSearchAvatarName")
                   .flatMap({ searchText in
                       return self.application.avatarService.getAvatar(searchText: searchText)
                   })
                   .flatMap({ avatar -> Observable<UIImage?> in
                       return self.dataOfUrl(avatar.avatarUrl)
                   })
                   .debug("rxSearchAvatar")
                   .subscribe(_searchAvatar)
                   .disposed(by: disposeBag)

        print("end init")
    }

    func dataOfUrl(_ url: URL?) -> Observable<UIImage?> {
        Observable<URL?>.never().startWith(url)
            .observe(on: backgroundScheduler)
            .flatMapLatest { url throws -> Observable<Data> in
                guard let url = url else { return Observable.just(Data()) }
                guard let data = try? Data(contentsOf: url) else { return Observable.just(Data()) }
                return Observable.just(data)
            }
            .map {
                UIImage(data: $0) ?? nil
            }
            .observe(on: MainScheduler.instance)
            .debug("dataOfUrl")
    }

    func getRandom() {

        application.emojiSource.fetchEmojis()
            .subscribe(onSuccess: { event in

                let randomEmoji = event.randomElement()?.imageUrl

                self.rxEmojiImageUrl.onNext(randomEmoji)

            },
                       onFailure: { error in
                print("[GetEmojisList-ViewModel] \(error)")},

                       onDisposed: {
                print("GOOOOOOO")
            })

            .disposed(by: disposeBag)
    }

    func getAvatar(searchText: String) {
          self.searchAvatarName.onNext(searchText)

      }
}
