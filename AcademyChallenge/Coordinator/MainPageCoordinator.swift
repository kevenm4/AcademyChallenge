//
//  MainPageCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit

class MainPageCoordinator: Coordinator {
	
	
	private let presenter: UINavigationController
	  private var mainPageViewController: MainPageViewControler?
	  private var emojis: [Emoji]?
	private var avatarPersitence: AvatarCoreData = AvatarCoreData()
	
	
	init( presenter:UINavigationController){
		self.presenter = presenter
	}
	

	
	func start() {
		
		
		
		let mainViewController = MainPageViewControler()
		
		mainViewController.emojiService = emojiSource
		mainViewController.persistence = avatarPersitence
		presenter.pushViewController(mainViewController, animated: true)
		
		self.mainPageViewController = mainViewController
		
	
		

	}
	
	
	
	
}

