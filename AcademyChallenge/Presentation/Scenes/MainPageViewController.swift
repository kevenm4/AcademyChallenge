//
//  MainPageViewControler.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 23/09/2022.
//

import UIKit
//
import RxSwift

public protocol MainPageViewControlerDelegate: AnyObject {
    func navigateToEmojiList()
    func navigateToAvatar()
    func navigateToRepos()
}
class MainPageViewControler: BaseGenericViewController<MainView> {
    public weak var delegate: MainPageViewControlerDelegate?
    
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
                
                viewModel?.searchAvatar
                .subscribe(genericView.emojiImageView.rx.image)
                .disposed(by: disposeBag)
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
    func didTapEmojiList() {
        self.delegate?.navigateToEmojiList()
    }
    func didTapAvatarList() {
        self.delegate?.navigateToAvatar()
    }
    func didTapRepoiList() {
        
        self.delegate?.navigateToRepos()
    }
    func didTapRandomEmojiButton() {
        
        viewModel?.getRandom()
    }
    
    func saveSearchContent() {
        
        guard let searchBarText = genericView.searchInput.text else { return }
        viewModel?.getAvatar(searchText: searchBarText)
    }
}
