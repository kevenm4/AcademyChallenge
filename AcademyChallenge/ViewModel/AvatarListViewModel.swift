//
//  AvatarListViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 27/10/2022.
//

import Foundation
//
import RxSwift
class AvatarListViewModel {
    var avatarService: LiveAvatarStorage?
    var arrAvatar: Box<[Avatar]?> = Box([])
    func getAvatar() -> Single<[Avatar]> {
        guard let avatarService = avatarService else {
            return Single<[Avatar]>.never()
        }
        return avatarService.fetchAvatar()
    }
    func delete(avatar: Avatar) -> Completable {
        guard let avatarService = avatarService else {
            return Completable.error(ConstantsError.serviceError)
        }

        return avatarService.deleteAvatar(avatarToDelete: avatar)
    }
}
