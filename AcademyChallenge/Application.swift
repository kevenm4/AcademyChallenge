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

    let emojiSource: EmojiService
    let avatarService: LiveAvatarStorage
    let reposSource: ReposService
     let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = .init(name: "GeneralEntity")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        })
        emojiSource = LiveEmojiStorage(persistentContainer: persistentContainer)
        avatarService = LiveAvatarStorage(persistentContainer: persistentContainer)
        reposSource = MockReposService()
    }

	static func initialize() {
		let sessionConfiguration = URLSessionConfiguration.default
		sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		urlSession = URLSession(configuration: sessionConfiguration)
	}

    // MARK: - Core Data stack

//    // MARK: - Core Data Saving support
//        func saveContext () {
//          let context = persistentContainer.viewContext
//          if context.hasChanges {
//            do {
//              try context.save()
//            } catch {
//              let nserror = error as NSError
//              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//          }
//        }
}
