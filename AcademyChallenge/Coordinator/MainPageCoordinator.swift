//
//  MainPageCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit

class MainPageCoordinator: Coordinator, EmojiPresenter, AvatarPresenter {
	
	
	
	
	var navigationController: UINavigationController?
	
	var emojiStorage: EmojiStorage?
	
	var avatarStorage: AvatarStorage?
	
	var liveEmojiStorage: LiveEmojiStorage = .init()
	
	
	init( emojiStorage: EmojiStorage, avatarStorage: AvatarStorage){
		self.emojiStorage = emojiStorage
		self.emojiStorage?.delegate = self
		self.avatarStorage = avatarStorage
		self.avatarStorage?.delegates = self
	}
	
	
	func eventOccurred(with type: Event) {
		
		switch type {
		case .buttonTappedEmojiList:
			
			var emojisList: UIViewController & Coordinating & EmojiPresenter = EmojiListViewController()
			
			emojisList.coordinator = self
			
			emojisList.emojiStorage = emojiStorage
			
			navigationController?.pushViewController(emojisList, animated: true)
			
			
		case .buttonTappedAvatarList:
			
			var avatarList: UIViewController & Coordinating & AvatarPresenter = AvatarViewController()
		
			
			avatarList.coordinator = self
			
			avatarList.avatarStorage = avatarStorage
			
			
			navigationController?.pushViewController(avatarList, animated: true)
		
		case .buttonTappedRepoList:
			
			var repoList: UIViewController & Coordinating = RepoListViewController()
			
			repoList.coordinator = self
			navigationController?.pushViewController(repoList, animated: true)
		
		}
		
	}
	
	func start() {
		
		var mainView: UIViewController & Coordinating & EmojiPresenter & AvatarPresenter = MainPageViewControler()
		
		mainView.coordinator = self
		
		mainView.emojiStorage = emojiStorage
		
			liveEmojiStorage.fetchEmojis({ (result: EmojiResponse) in
			
					mainView.emojiStorage?.emojis = result.emojis
			
				mainView.emojiStorage?.emojis.sort()
			
					})
			
		mainView.avatarStorage = avatarStorage
		
		
		navigationController?.setViewControllers([mainView], animated: false)

	}
	
	
	
}
extension MainPageCoordinator: EmojiStorageDelegate {
	
	func emojiListUpdated() {
		navigationController?.viewControllers.forEach {
			($0 as? EmojiPresenter)?.emojiListUpdated()
		}
	}
}

extension MainPageCoordinator: AvatarStorageDelegate {
	
	func avatarListUpdate() {
		
		navigationController?.viewControllers.forEach {
			
			($0 as? AvatarPresenter)?.avatarListUpdate()
		}
		
	}
}


