//
//  Application.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 30/09/2022.
//

import Foundation
import CoreData

class Application {
	static var urlSession: URLSession?

    let emojiSource: LiveEmojiStorage
    let avatarService: LiveAvatarStorage
    let reposSource: LiveReposStorage

    init(persistentContainer: NSPersistentContainer) {
        emojiSource = LiveEmojiStorage(persistentContainer: persistentContainer)
        avatarService = LiveAvatarStorage(persistentContainer: persistentContainer)
        reposSource = LiveReposStorage()
    }

	static func initialize() {
		let sessionConfiguration = URLSessionConfiguration.default
		sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		urlSession = URLSession(configuration: sessionConfiguration)
	}
}
