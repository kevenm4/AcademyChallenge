//
//  MainPageCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit
class MainPageCoordinator: Coordinator {
    var chillCoordinators: [Coordinator] = []
    var application: Application
    private let presenter: UINavigationController
    init(presenter: UINavigationController, application: Application) {
        self.presenter = presenter
        self.application = application
    }
    func start() {
        let viewModel = MainPagelViewModel(application: application)
        viewModel.application = application
        let mainPageViewControler: MainPageViewControler = MainPageViewControler()
        mainPageViewControler.delegate = self
        mainPageViewControler.viewModel = viewModel
        presenter.pushViewController(mainPageViewControler, animated: true)
        //  self.presenter.viewControllers = [mainPageViewControler]
    }
}

extension MainPageCoordinator: MainPageViewControlerDelegate {
    // Navigate to next page
    func navigateToEmojiList() {
        let emojiListCoordinator = EmojiListCoordinator(presenter: presenter, emojiService: application.emojiSource)
        emojiListCoordinator.delegate = self
        chillCoordinators.append(emojiListCoordinator)
        emojiListCoordinator.start()
    }
    func navigateToAvatar() {
        let avatarListCoordinator = AvatarListCoordinator(presenter: presenter,
                                                          avatarService: application.avatarService)
        avatarListCoordinator.delegate = self
        chillCoordinators.append(avatarListCoordinator)
        avatarListCoordinator.start()
    }
    func navigateToRepos() {
        let repoListCoordinator = RepoListCoordinator(presenter: presenter, reposService: application.reposSource)
        repoListCoordinator.delegate = self
        chillCoordinators.append(repoListCoordinator)
        repoListCoordinator.start()
    }
}

extension MainPageCoordinator: BackToFirstViewControllerDelegate {
    func navigateBackToFirstPage() {
        //    presenter.popToRootViewController(animated: true)
        chillCoordinators.removeLast()
    }
}
