//
//  AvatarListViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 27/10/2022.
//

import Foundation

class AvatarListViewModel {
    	var avatarService: LiveAvatarStorage?
    	var arrAvatar: Box<[Avatar]?> = Box([])
    func getAvatar() {
        avatarService?.fetchAvatar({ (result: [Avatar]) in
            self.arrAvatar.value = result
        })
    }
    func deleteAV(avatar: Avatar) {
        self.avatarService?.deleteAvatar(avatarToDelete: avatar)
    }
}
