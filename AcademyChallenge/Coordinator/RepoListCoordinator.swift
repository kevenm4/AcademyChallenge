//
//  RepoListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import Foundation
import UIKit

class RepoListCoordinator: Coordinator {

	private let presenter: UINavigationController

	private var repoListViewControler: RepoListViewController?

	init(presenter: UINavigationController) {

		self.presenter = presenter
	}
	func start() {
		let viewModel = ReposListViewModel()
		viewModel.reposService = reposSource
		let repoListViewController = RepoListViewController()
		repoListViewController.viewModel = viewModel
		presenter.pushViewController(repoListViewController, animated: true)
		self.repoListViewControler = repoListViewController
	}

}
