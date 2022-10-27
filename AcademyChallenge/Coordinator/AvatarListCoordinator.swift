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
	
	
	init(presenter: UINavigationController ){
		
		self.presenter = presenter
		
		
	}
	
	
	func start() {
		
		
		let viewModel = AvatarListViewModel()
		viewModel.avatarService = avatarService
		let avatarViewController = AvatarViewController()
		avatarViewController.viewModel = viewModel
		presenter.pushViewController(avatarViewController, animated: true)
		self.avatarViewController = avatarViewController
		
	}
	
}
