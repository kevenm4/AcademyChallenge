//
//  AvatarListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import Foundation
import UIKit

class AvatarListCoordinator: Coordinator {
	
	
	private let presenter : UINavigationController
	
	private var avatarViewController: AvatarViewController?
	private var avatarPersitence: AvatarCoreData
	
	init(presenter: UINavigationController , avatarPersitence:AvatarCoreData){
		
		self.presenter = presenter
		self.avatarPersitence = avatarPersitence
		
	}
	
	
	func start() {
		
		let avatarViewController = AvatarViewController()
		
		avatarViewController.persistence = avatarPersitence
		
		presenter.pushViewController(avatarViewController, animated: true)
		
		self.avatarViewController = avatarViewController
		
	}
	
}
