//
//  MainPageViewControler.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 23/09/2022.
//

import UIKit
//
import RxSwift
class MainPageViewControler: BaseGenericViewController<MainView> {

    private var emojiListCoordinator: EmojiListCoordinator?
    private var avatarListCoordinator: AvatarListCoordinator?
    private var repoListCoordinator: RepoListCoordinator?
    // var mainView = MainView()
    var viewModel: MainPagelViewModel?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override func loadView() {
//
//        view = mainView
//    }
    override func viewDidLoad() {

        super.viewDidLoad()
        genericView.emojiImageView.showLoading()
        viewModel?.rxEmojiImage
            .do(onNext: { [weak self] image in
                guard image != nil else { return }
                self?.genericView.emojiImageView.stopLoading()

            })
                .subscribe(genericView.emojiImageView.rx.image)
                .disposed(by: disposeBag)
//        viewModel?.emojiImage.bind { imageUrl in
//            DispatchQueue.main.async {
//                self.genericView.emojiImageView.image = nil
//                guard let imageUrl = imageUrl else { return }
//                self.genericView.emojiImageView.stopLoading()
//                self.genericView.emojiImageView.downloadImage(from: imageUrl)
//                //   self.emojiList.isEnabled = true
//            }
//        }
        // setUpButton()
        didTapRandomEmojiButton()

        genericView.rxRandomEmojiTap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapRandomEmojiButton()
            })
            .disposed(by: disposeBag)
        genericView.rxEmojiListTap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapEmojiList()
            })
            .disposed(by: disposeBag)
        genericView.rxAvatarListTap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapAvatarList()
            })
            .disposed(by: disposeBag)
        genericView.rxAppleReposTap
            .subscribe(onNext: { [weak self] _ in
                self?.didTapRepoiList()
            })
            .disposed(by: disposeBag)
        genericView.rxSearchTap
            .subscribe(onNext: { [weak self] _ in
                self?.saveSearchContent()
            })
            .disposed(by: disposeBag)

    }
//    private func setUpButton() {
//        mainView.emojiList.addTarget(self, action: #selector(didTapEmojiList), for: .touchUpInside)
//        mainView.searchButton.addTarget(self, action: #selector(saveSearchContent), for: .touchUpInside)
//        mainView.avatarList.addTarget(self, action: #selector(didTapAvatarList), for: .touchUpInside)
//        mainView.repoList.addTarget(self, action: #selector(didTapRepoiList), for: .touchUpInside)
//        mainView.randomButton.addTarget(self, action: #selector(didTapRandomEmojiButton), for: .touchUpInside)
//
//    }
     func didTapEmojiList() {
        guard let emojiService = viewModel?.application?.emojiSource else {return}

        let emojiListCoordinator = EmojiListCoordinator(presenter: navigationController!, emojiService: emojiService)

        emojiListCoordinator.start()

        self.emojiListCoordinator = emojiListCoordinator
    }
     func didTapAvatarList() {
        guard let avatarService = viewModel?.application?.avatarService else {return}
        let avatarListCoordinator = AvatarListCoordinator(presenter: navigationController!,
                                                          avatarService: avatarService )

        avatarListCoordinator.start()

        self.avatarListCoordinator = avatarListCoordinator

    }

     func didTapRepoiList() {
        guard let reposService = viewModel?.application?.reposSource else {return}

        let repoListCoordinator = RepoListCoordinator(presenter: navigationController!, reposService: reposService)

        repoListCoordinator.start()

        self.repoListCoordinator = repoListCoordinator

        // emojiList.isEnabled = false
    }
      func didTapRandomEmojiButton() {

        viewModel?.getRandom()
    }

     func saveSearchContent() {
                viewModel?.searchQuery.value = genericView.searchInput.text
    }
}
