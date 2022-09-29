//
//  MainPageCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit

class MainPageCoordinator: Coordinator, EmojiPresenter {
	
	var navigationController: UINavigationController?
	
	var emojiStorage: EmojiStorage?
	
	
	init( emojiStorage: EmojiStorage){
		self.emojiStorage = emojiStorage
		self.emojiStorage?.delegate = self
	}
	
	
	func eventOccurred(with type: Event) {
		
		switch type {
		case .buttonTappedEmojiList:
			
			var emojisList: UIViewController & Coordinating & EmojiPresenter = EmojiListViewController()
			
			emojisList.coordinator = self
			
			emojisList.emojiStorage = emojiStorage
			
			navigationController?.pushViewController(emojisList, animated: true)
			
		case .buttonTappedAvatarList:
			var avatarList: UIViewController & Coordinating = AvatarViewController()
			
			avatarList.coordinator = self
			navigationController?.pushViewController(avatarList, animated: true)
		
		case .buttonTappedRepoList:
			
			var repoList: UIViewController & Coordinating = RepoListViewController()
			
			repoList.coordinator = self
			navigationController?.pushViewController(repoList, animated: true)
		
		}
		
	}
	
	func start() {
		
		var mainView:UIViewController & Coordinating & EmojiPresenter = MainPageViewControler()
		
		mainView.coordinator = self
		
		mainView.emojiStorage = emojiStorage
		
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


