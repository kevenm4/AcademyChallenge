//
//  RepoListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import Foundation
import UIKit

class RepoListCoordinator: Coordinator {
    var chillCoordinators: [Coordinator] = []
    private let presenter: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
	 var repoListViewControler: RepoListViewController?
     var reposService: ReposService?
    init(presenter: UINavigationController, reposService: ReposService) {
            self.reposService = reposService
            self.presenter = presenter
        }
	func start() {
        let viewModel = ReposListViewModel()
        viewModel.reposService = reposService
        let repoListViewController: RepoListViewController = RepoListViewController()
        repoListViewController.delegate = self
        repoListViewController.viewModel = viewModel
        self.presenter.pushViewController(repoListViewController,
                                                     animated: true)
       // self.presenter.viewControllers = [repoListViewController]
	}

}

extension RepoListCoordinator: ReposViewControlerDelegate {
    func navigateToFirstPage() {
        self.delegate?.navigateBackToFirstPage()
    }
}
