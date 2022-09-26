//
//  MainPageCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit

class MainPageCoordinator: Coordinator {
	var navigationController: UINavigationController?
	
	func eventOccurred(with type: Event) {
		
		switch type {
		case .buttonTappedEmojiList:
			
			var emojisList: UIViewController & Coordinating = EmojiListViewController()
			emojisList.coordinator = self
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
		
		var mainView:UIViewController & Coordinating = MainPageViewControler()
		
		mainView.coordinator = self
		
		navigationController?.setViewControllers([mainView], animated: false)

	}
	

	


	
	
}
