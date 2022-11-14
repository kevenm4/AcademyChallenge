//
//  LiveAvatarStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import Foundation
import UIKit
import CoreData
//
import RxSwift

class LiveAvatarStorage {

    private	var avatarNetwork: Network = .init()

    private let avatarPersistence: AvatarCoreData

    init(persistentContainer: NSPersistentContainer) {
        avatarPersistence = AvatarCoreData(persistentContainer: persistentContainer)
    }

    func fetchAvatar() -> Single<[Avatar]> {

        return avatarPersistence.fetch()
//        avatarPersistence.fetch { (result: [Avatar]) in
//            if result.count != 0 {
//                resultHandler(result)
//            }
//        }
    }

    func getAvatar(searchText: String) -> Observable<Avatar> {

        return avatarPersistence.checkIfItemExist(searchText: searchText )
            .flatMap { avatar  -> <#Result#> in
                if avatar != nil {
                    return avatarNetwork.rxExecuteNetworkCall(AvatarAPI.getAvatar(searchText))
                }
                return Observable.just(avatar)
            }

//        avatarPersistence.checkIfItemExist(searchText: searchText) { ( result: Result<[NSManagedObject], Error>) in
//
//            switch result {
//            case .success(let success):
//                if success.count != 0 {
//
//                    guard let avatarFound = success.first else { return }
//                    guard let avatar = avatarFound.toAvatar() else { return }
//                    resultHandler(.success(avatar))
//                } else {
//
//                    // GET THE AVATAR FROM API
//                    self.avatarNetwork.executeNetworkCall(AvatarAPI.getAvatar(searchText))
//                    { (result: Result<Avatar, Error>) in
//
//                        switch result {
//
//                        case .success(let success):
//                            self.avatarPersistence.persist(currentAvatar: success)
//                            resultHandler(.success(success))
//                        case .failure(let failure):
//                            print("Failure: \(failure)")
//                            resultHandler(.failure(failure))
//                        }
//                    }
//                }
//            case .failure(let failure):
//                print("Failure to verify if avatar exists in Core data: \(failure)")
//            }
//        }

    }
    func deleteAvatar(avatarToDelete: Avatar) {

        avatarPersistence.delete(avatarObject: avatarToDelete)
    }

}
