//
//  MainPageViewControler.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 23/09/2022.
//

import UIKit

class MainPageViewControler: UIViewController, Coordinating {
	var coordinator: Coordinator?
	

	private var stackView: UIStackView
	private var secondStackView : UIStackView
	private var randomButton: UIButton
	private var emojiList: UIButton
	private var repoList: UIButton
	private var avatarList: UIButton
	private var searchButton: UIButton
	private var searchInput: UISearchBar
	private var image : UIImageView
	init() {
		
		randomButton = .init(type: .system)
		emojiList = .init(type: .system)
		searchButton = .init(type: .system)
		repoList = .init(type: .system)
		avatarList = .init(type: .system)
		searchInput = .init()
		image = .init(frame: .zero)
		secondStackView = .init(arrangedSubviews: [searchInput,searchButton])
		stackView = .init(arrangedSubviews: [randomButton,emojiList,secondStackView,avatarList,repoList])
		super.init(nibName: nil, bundle: nil)
	}
	required init(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let url = URL(string: "https://github.githubassets.com/images/icons/emoji/unicode/1f1e6-1f1e9.png?v8")!
		   downloadImage(from: url)
		
		view.backgroundColor = .blue
		view.tintColor = .gray
		setUpView()
		addtoSuperView()
		setUpConstraints()
		setUpButton()
		
		
		// Do any additional setup after loading the view.
	}

	//override func viewWillAppear(_ animated: Bool) {
		//super.viewWillAppear(animated)
		//navigationController?.setNavigationBarHidden(true, animated: animated)
	//}
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
		//image.image = UIImage(named: "emoji")
		
	}
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	
	func downloadImage(from url: URL) {
		
		getData(from: url) { data, response, error in
			guard let data = data, error == nil else { return }
			print(response?.suggestedFilename ?? url.lastPathComponent)
			DispatchQueue.main.async() { [weak self] in
				self?.image.image = UIImage(data: data)
			}
		}
	}
	
	// 3- Add to superView
	
	private func addtoSuperView(){
		view.addSubview(stackView)
		view.addSubview(image)
		
	}
	
	// 4- set the constraints
	
	private func setUpConstraints(){
		stackView.translatesAutoresizingMaskIntoConstraints = false
		image.translatesAutoresizingMaskIntoConstraints = false
	
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			image.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
			image.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20),
			image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			image.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
			
		])
	}
	
	@objc func didTapEmojiList() {
		
		coordinator?.eventOccurred(with: .buttonTappedEmojiList)
		
	}
	@objc func didTapAvatarList() {
		
		coordinator?.eventOccurred(with: .buttonTappedAvatarList)
		
	}
	
	@objc func didTapRepoiList() {
		
		coordinator?.eventOccurred(with: .buttonTappedRepoList)
		
	}
	
	
}

