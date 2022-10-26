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
	
	init( presenter:UINavigationController){
		self.presenter = presenter
	}
	
	func start() {
		let viewModel = MainPageViewModel(emojiService: emojiSource, avatarService: avatarService)
		let mainViewController = MainPageViewControler(viewModel: viewModel)
		presenter.pushViewController(mainViewController, animated: true)
		self.mainPageViewController = mainViewController
	}
}

