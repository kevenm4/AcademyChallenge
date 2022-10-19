//
//  Coordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation


protocol Coordinator {
	
	func start()
	
}

var emojiSource = LiveEmojiStorage()

var avatarService = LiveAvatarStorage()

var reposService = MockReposService()


