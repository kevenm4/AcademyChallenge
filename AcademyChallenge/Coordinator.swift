//
//  Coordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit

enum Event {
	
	case buttonTappedEmojiList
	case buttonTappedAvatarList
	case buttonTappedRepoList
	
}
protocol Coordinator{
	var navigationController: UINavigationController? {get set}
	
	func eventOccurred(with type: Event)
	func start()
}

protocol Coordinating {
	var coordinator : Coordinator? {get set}
}

protocol EmojiPresenter: EmojiStorageDelegate {
	
	var emojiStorage: EmojiStorage? { get set }
}

protocol EmojiStorage {
	
	var delegate: EmojiStorageDelegate? { get set }
	var emojis: [Emoji] { get set }
}

protocol EmojiStorageDelegate: AnyObject {
	func emojiListUpdated()
}
