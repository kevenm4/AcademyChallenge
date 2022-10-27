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
    private let application: Application

    init(presenter: UINavigationController, application: Application) {
		self.presenter = presenter
        self.application = application
	}

	func start() {
		let viewModel = MainPagelViewModel()
        viewModel.emojiService = application.emojiSource
        viewModel.avatarService = application.avatarService
		let mainViewController = MainPageViewControler()
		mainViewController.viewModel = viewModel
		presenter.pushViewController(mainViewController, animated: true)
		self.mainPageViewController = mainViewController
	}
}
