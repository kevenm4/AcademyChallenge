//
//  EmojiListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import UIKit
class EmojiListCoordinator: Coordinator {
    var chillCoordinators: [Coordinator] = []
    let presenter: UINavigationController
    private let emojiService: EmojiService
    weak var delegate: BackToFirstViewControllerDelegate?
    init(presenter: UINavigationController, emojiService: EmojiService) {
        self.emojiService = emojiService
        self.presenter = presenter
    }
    func start() {
        let viewModel = EmojiListViewModel()
        viewModel.emojiService = emojiService
        let emojiListViewController: EmojiListViewController = EmojiListViewController()
        emojiListViewController.delegate = self
        emojiListViewController.viewModel = viewModel
        self.presenter.pushViewController(emojiListViewController,
                                          animated: true)
    }
}

extension EmojiListCoordinator: BackToFirstViewControllerDelegate {
    func navigateBackToFirstPage() {
        self.delegate?.navigateBackToFirstPage()
    }
}
