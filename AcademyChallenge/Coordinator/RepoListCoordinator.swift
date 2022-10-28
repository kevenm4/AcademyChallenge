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
    private let reposService: ReposService
	init(presenter: UINavigationController, reposService: ReposService) {
        self.reposService = reposService
		self.presenter = presenter
	}
	func start() {
		let viewModel = ReposListViewModel()
        viewModel.reposService = reposService
		let repoListViewController = RepoListViewController()
		repoListViewController.viewModel = viewModel
		presenter.pushViewController(repoListViewController, animated: true)
		self.repoListViewControler = repoListViewController
	}

}
