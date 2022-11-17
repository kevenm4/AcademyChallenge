//
//  EmojiListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import UIKit

protocol BackToFirstViewControllerDelegate: AnyObject {
    
    func navigateBackToFirstPage()
    
}

class EmojiListCoordinator: Coordinator {
    var chillCoordinators: [Coordinator] = []
    unowned let presenter: UINavigationController
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
        //   self.presenter.viewControllers = [emojiListViewController]
    }
    
    //    func start() {
    //
    //        let viewModel = EmojiListViewModel()
    //        viewModel.emojiService = emojiService
    //        let emojiListViewController = EmojiListViewController()
    //        emojiListViewController.viewModel = viewModel
    //
    //        presenter.pushViewController(emojiListViewController, animated: true)
    //
    //        self.emojiListViewController = emojiListViewController
    //    }
    
}

extension EmojiListCoordinator: EmojiListViewControlerDelegate {
    func navigateToFirstPage() {
        self.delegate?.navigateBackToFirstPage()
    }
}
