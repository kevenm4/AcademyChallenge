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
    }
    
    func getAvatar(searchText: String) -> Observable<Avatar> {
        
        return avatarPersistence.checkIfItemExist(searchText: searchText)
            .flatMap({ avatar -> Observable<Avatar> in
                guard
                    let avatar = avatar else {
                    return self.avatarNetwork.rxExecuteNetworkCall(AvatarAPI.getAvatar(searchText))
                        .do { (result: Avatar) in
                            self.avatarPersistence.persist(currentAvatar: result)
                        }
                        .asObservable()
                }
                return Observable.just(avatar)
            })
    }
    //    func deleteAvatar(avatarToDelete: Avatar) {
    //
    //        avatarPersistence.delete(avatarObject: avatarToDelete)
    //    }
}
