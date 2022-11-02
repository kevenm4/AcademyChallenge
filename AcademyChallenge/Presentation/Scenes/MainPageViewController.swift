//
//  MainPageViewControler.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 23/09/2022.
//

import UIKit

class MainPageViewControler: UIViewController {

	private var emojiListCoordinator: EmojiListCoordinator?
	private var avatarListCoordinator: AvatarListCoordinator?
	private var repoListCoordinator: RepoListCoordinator?
	private var stackView: UIStackView
	private var secondStackView: UIStackView
	private var randomButton: UIButton
	private var emojiList: UIButton
	private var repoList: UIButton
	private var avatarList: UIButton
	private var searchButton: UIButton
	private var searchInput: UISearchBar
	private var emojiImageView: UIImageView
	private var containerView: UIView
	 var viewModel: MainPagelViewModel?

	init() {

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

		super.init(nibName: nil, bundle: nil)
	}

	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {

		super.viewDidLoad()

		viewModel?.emojiImage.bind { imageUrl in
            DispatchQueue.main.async {
                self.emojiImageView.image = nil
                guard let imageUrl = imageUrl else { return }
                self.emojiImageView.stopLoading()
                self.emojiImageView.downloadImageFromURL(from: imageUrl)
                    self.emojiList.isEnabled = true
            }
//			guard let imageUrl = imageUrl else { return }
//			self.emojiImageView.stopLoading()
//			self.emojiImageView.downloadImageFromURL(from: imageUrl)
//                self.emojiList.isEnabled = true

		}

		view.backgroundColor = UIColor.appColor(.primary)
		view.tintColor = UIColor.appColor(.secondary)
		setUpView()
		addtoSuperView()
		setUpConstraints()
		setUpButton()
		didTapRandomEmojiButton()

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

	}

	// 1- setUp the view

	private func setUpView() {

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

	// 2- setUp button

	private func setUpButton() {

		randomButton.setTitleColor(.white, for: .normal)
		randomButton.configuration = .filled()
		emojiList.setTitleColor(.white, for: .normal)
		emojiList.configuration = .filled()
		emojiList.addTarget(self, action: #selector(didTapEmojiList), for: .touchUpInside)
		searchButton.setTitleColor(.white, for: .normal)
		searchButton.configuration = .filled()
		searchButton.addTarget(self, action: #selector(saveSearchContent), for: .touchUpInside)
		avatarList.setTitleColor(.white, for: .normal)
		avatarList.addTarget(self, action: #selector(didTapAvatarList), for: .touchUpInside)
		avatarList.configuration = .filled()
		repoList.setTitleColor(.white, for: .normal)
		repoList.addTarget(self, action: #selector(didTapRepoiList), for: .touchUpInside)
		repoList.configuration = .filled()

		randomButton.addTarget(self, action: #selector(didTapRandomEmojiButton), for: .touchUpInside)

	}

	// 3- Add to superView

	private func addtoSuperView() {
		view.addSubview(stackView)
		containerView.addSubview(emojiImageView)
		view.addSubview(containerView)

	}

	// 4- set the constraints

	private func setUpConstraints() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		containerView.translatesAutoresizingMaskIntoConstraints = false
		emojiImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.1 * view.frame.width),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0.1 * view.frame.width),
			containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.1 * view.frame.height),
			containerView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -0.1 * view.frame.height),

			emojiImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                    constant: 0.25 * containerView.frame.width),
            emojiImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                     constant: -0.25 * containerView.frame.width),
			emojiImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.25 * containerView.frame.height),
			emojiImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                   constant: -0.25 * containerView.frame.height)
		])
		emojiImageView.contentMode = .scaleAspectFit
	}

	// 5- Button func to call event

	@objc func didTapEmojiList() {
        guard let emojiService = viewModel?.application?.emojiSource else {return}

        let emojiListCoordinator = EmojiListCoordinator(presenter: navigationController!, emojiService: emojiService)

		emojiListCoordinator.start()

		self.emojiListCoordinator = emojiListCoordinator
	}
	@objc func didTapAvatarList() {
        guard let avatarService = viewModel?.application?.avatarService else {return}
		let avatarListCoordinator = AvatarListCoordinator(presenter: navigationController!, avatarService: avatarService )

		avatarListCoordinator.start()

		self.avatarListCoordinator = avatarListCoordinator

	}

	@objc func didTapRepoiList() {
        guard let reposService = viewModel?.application?.reposSource else {return}

		let repoListCoordinator = RepoListCoordinator(presenter: navigationController!, reposService: reposService)

		repoListCoordinator.start()

		self.repoListCoordinator = repoListCoordinator

        emojiList.isEnabled = false
	}

	// 6- get random emojis

	@objc  func didTapRandomEmojiButton() {

		viewModel?.getRandom()
	}

	@objc func saveSearchContent() {

		viewModel?.searchQuery.value = searchInput.text
	}
}
