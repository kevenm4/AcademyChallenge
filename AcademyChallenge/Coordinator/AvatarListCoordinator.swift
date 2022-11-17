//
//  AvatarListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import Foundation
import UIKit

class AvatarListCoordinator: Coordinator {
    var chillCoordinators: [Coordinator] = []
    private let presenter: UINavigationController
    weak var delegate: BackToFirstViewControllerDelegate?
    var avatarViewController: AvatarViewController?
    var avatarService: LiveAvatarStorage
    init(presenter: UINavigationController, avatarService: LiveAvatarStorage ) {

        self.presenter = presenter
        self.avatarService = avatarService

    }
    func start() {
        let viewModel = AvatarListViewModel()
        viewModel.avatarService = avatarService
        let avatarViewController: AvatarViewController = AvatarViewController()
        avatarViewController.delegate = self
        avatarViewController.viewModel = viewModel
        self.presenter.pushViewController(avatarViewController,
                                          animated: true)
        //  self.presenter.viewControllers = [avatarViewController]

    }

}

extension AvatarListCoordinator: BackToFirstViewControllerDelegate {
    func navigateBackToFirstPage() {
        self.delegate?.navigateBackToFirstPage()
    }
}
