//
//  MainView.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/11/2022.
//

import Foundation
import UIKit
//
import RxCocoa
import RxSwift
class MainView: BaseGenericView {
    
    var stackView: UIStackView
    var secondStackView: UIStackView
    var randomButton: UIButton
    var emojiList: UIButton
    var repoList: UIButton
    var avatarList: UIButton
    var searchButton: UIButton
    var searchInput: UISearchBar
    var emojiImageView: UIImageView
    var containerView: UIView
    var rxRandomEmojiTap: Observable<Void> {randomButton.rx.tap.asObservable() }
    var rxEmojiListTap: Observable<Void> { emojiList.rx.tap.asObservable() }
    var rxAvatarListTap: Observable<Void> { avatarList.rx.tap.asObservable() }
    var rxAppleReposTap: Observable<Void> { repoList.rx.tap.asObservable() }
    var rxSearchTap: Observable<Void> { searchButton.rx.tap.asObservable() }
    required init() {
        randomButton = .init(type: .system)
        emojiList = .init(type: .system)
        searchButton = .init(type: .system)
        repoList = .init(type: .system)
        avatarList = .init(type: .system)
        searchInput = .init()
        containerView = .init(frame: .zero)
        emojiImageView = .init(frame: .zero)
        secondStackView = .init(arrangedSubviews: [searchInput, searchButton])
        stackView = .init(arrangedSubviews: [randomButton, emojiList, secondStackView, avatarList, repoList])
        super.init()
        createSubView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubView() {
        setUpView()
        addtoSuperView()
        setUpConstraints()
        setUpButton()
    }
    private func setUpView() {
        backgroundColor = UIColor.appColor(.primary)
        tintColor = UIColor.appColor(.secondary)
        stackView.axis = .vertical
        secondStackView.axis = .horizontal
        secondStackView.spacing = CGFloat(5)
        stackView.spacing = CGFloat(15)
        randomButton.setTitle("RANDOM EMOJI", for: .normal)
        emojiList.setTitle("EMOJI LIST", for: .normal)
        searchButton.setTitle("SEARCH", for: .normal)
        avatarList.setTitle("AVATAR LIST", for: .normal)
        repoList.setTitle("APPLE REPOS", for: .normal)
        emojiImageView.showLoading()
    }
    private func setUpButton() {
        randomButton.setTitleColor(.white, for: .normal)
        randomButton.configuration = .filled()
        emojiList.setTitleColor(.white, for: .normal)
        emojiList.configuration = .filled()
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.configuration = .filled()
        avatarList.setTitleColor(.white, for: .normal)
        avatarList.configuration = .filled()
        repoList.setTitleColor(.white, for: .normal)
        repoList.configuration = .filled()
    }
    private func addtoSuperView() {
        addSubview(stackView)
        containerView.addSubview(emojiImageView)
        addSubview(containerView)
    }
    private func setUpConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            emojiImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                    constant: 0.25),
            emojiImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                     constant: -0.25),
            emojiImageView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                constant: 80),
            emojiImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                   constant: -80)
        ])
        emojiImageView.contentMode = .scaleAspectFit
    }
}
