//
//  EmojiListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import UIKit

class EmojiListCoordinator: Coordinator {

	private let presenter: UINavigationController

	private var emojiListViewController: EmojiListViewController?

	init(presenter: UINavigationController) {

		self.presenter = presenter
	}
	func start() {

		let viewModel = EmojiListViewModel()
		viewModel.emojiService = emojiSource
		let emojiListViewController = EmojiListViewController()
		emojiListViewController.viewModel = viewModel

		presenter.pushViewController(emojiListViewController, animated: true)

		self.emojiListViewController = emojiListViewController
	}

}
