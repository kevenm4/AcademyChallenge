//
//  EmojiListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import UIKit

import UIKit


class EmojiListCoordinator: Coordinator {
	
	
	
	private let presenter : UINavigationController
	
	private var emojiListViewController: EmojiListViewController?
	
	init(presenter: UINavigationController){
		
		self.presenter = presenter
	}
	func start() {
		
		let emojiListViewController = EmojiListViewController()
		
		emojiListViewController.emojiService = emojiSource
		
		presenter.pushViewController(emojiListViewController, animated: true)
		
		self.emojiListViewController = emojiListViewController
	}
	
}

