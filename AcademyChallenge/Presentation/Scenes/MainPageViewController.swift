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
	private var secondStackView : UIStackView
	private var randomButton: UIButton
	private var emojiList: UIButton
	private var repoList: UIButton
	private var avatarList: UIButton
	private var searchButton: UIButton
	private var searchInput: UISearchBar
	private var emojiImage : UIImageView
	private var containerView : UIView
	var emojiService: EmojiService?
	
	init() {
		
		randomButton = .init(type: .system)
		emojiList = .init(type: .system)
		searchButton = .init(type: .system)
		repoList = .init(type: .system)
		avatarList = .init(type: .system)
		searchInput = .init()
		containerView = .init(frame : .zero)
		emojiImage = .init(frame: .zero)
		secondStackView = .init(arrangedSubviews: [searchInput,searchButton])
		stackView = .init(arrangedSubviews: [randomButton,emojiList,secondStackView,avatarList,repoList])
		
		super.init(nibName: nil, bundle: nil)
	}
	
	
	required init(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
		
	}
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		//getEmojis()
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
	
	private func setUpView(){
		stackView.axis = .vertical
		secondStackView.axis = .horizontal
		secondStackView.spacing = CGFloat(5)
		stackView.spacing = CGFloat(15)
		randomButton.setTitle("RANDOM EMOJI", for: .normal)
		emojiList.setTitle("EMOJI LIST", for: .normal)
		searchButton.setTitle("SEARCH", for: .normal)
		avatarList.setTitle("AVATAR LIST", for: .normal)
		repoList.setTitle("APPLE REPOS", for: .normal)

	}
	
	
	// 2- setUp button
	
	private func setUpButton(){
		
		randomButton.setTitleColor(.white, for: .normal)
		randomButton.configuration = .filled()
		emojiList.setTitleColor(.white, for: .normal)
		emojiList.configuration = .filled()
		emojiList.addTarget(self, action: #selector(didTapEmojiList), for: .touchUpInside)
		searchButton.setTitleColor(.white, for: .normal)
		searchButton.configuration = .filled()
		avatarList.setTitleColor(.white, for: .normal)
		avatarList.addTarget(self, action: #selector(didTapAvatarList), for: .touchUpInside)
		avatarList.configuration = .filled()
		repoList.setTitleColor(.white, for: .normal)
		repoList.addTarget(self, action: #selector(didTapRepoiList), for: .touchUpInside)
		repoList.configuration = .filled()
		
		randomButton.addTarget(self, action: #selector(didTapRandomEmojiButton), for: .touchUpInside)
	   
		
	}
	
	
	
	// 3- Add to superView
	
	private func addtoSuperView(){
		view.addSubview(stackView)
		containerView.addSubview(emojiImage)
		view.addSubview(containerView)
		
	}
	
	// 4- set the constraints
	
	private func setUpConstraints(){
		stackView.translatesAutoresizingMaskIntoConstraints = false
		containerView.translatesAutoresizingMaskIntoConstraints = false
		emojiImage.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20),
			containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			containerView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
			emojiImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			emojiImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
			
		])
	}
	
	// 5- Button func to call event
	
	@objc func didTapEmojiList() {
		
		let emojiListCoordinator = EmojiListCoordinator(presenter: navigationController!)
			  
			  emojiListCoordinator.start()

			  self.emojiListCoordinator = emojiListCoordinator
		
	}
	@objc func didTapAvatarList() {
		
		let avatarListCoordinator = AvatarListCoordinator(presenter: navigationController!)
			  
		avatarListCoordinator.start()

			  self.avatarListCoordinator = avatarListCoordinator
		
	}
	
	@objc func didTapRepoiList() {
		
		let repoListCoordinator = RepoListCoordinator(presenter: navigationController!)
			  
		repoListCoordinator.start()

			  self.repoListCoordinator = repoListCoordinator
		
		
	}
	
	
	//6- get random emojis
	
	@objc  func didTapRandomEmojiButton() {
		
		emojiService?.fetchEmojis({ [weak self] (result: Result<[Emoji],Error>) in
				   switch result{
				   case .success(let success):
					   
					  guard let randomUrl = success.randomElement()?.imageUrl else { return }
					   
					   self?.emojiImage.downloadImageFromURL(from: randomUrl)
					   
				   case .failure(let failure):
					   print("Failure: \(failure)")
					   self?.emojiImage.image = UIImage(named: "noEmoji")
				   }
				   
			   })
		   }
		}
		

extension Array {
	func item(at: Int) -> Element? {
		
		count > at ? self[at] : nil
	}
}
