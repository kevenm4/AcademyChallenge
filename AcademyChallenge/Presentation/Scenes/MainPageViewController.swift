//
//  MainPageViewControler.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 23/09/2022.
//

import UIKit

class MainPageViewControler: UIViewController, Coordinating, EmojiPresenter, AvatarPresenter {

	var emojiStorage: EmojiStorage?
	var coordinator: Coordinator?
	var avatarStorage: AvatarStorage?
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
		view.backgroundColor = .blue
		view.tintColor = .gray
		setUpView()
		addtoSuperView()
		setUpConstraints()
		setUpButton()
		
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		didTapRandomEmojiButton()
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
	
	//3- Add image from internet
	
	
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
		
	}
	
	func downloadImage(from url: URL) {
		
		getData(from: url) { data, response, error in
			guard let data = data, error == nil else { return }
			
			print(response?.suggestedFilename ?? url.lastPathComponent)
			DispatchQueue.main.async() { [weak self] in
				self?.emojiImage.image = UIImage(data: data)
			}
		}
	}
	
	// 4- Add to superView
	
	private func addtoSuperView(){
		view.addSubview(stackView)
		containerView.addSubview(emojiImage)
		view.addSubview(containerView)
		
	}
	
	// 5- set the constraints
	
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
	
	// 6- Button func to call event
	
	@objc func didTapEmojiList() {
		
		coordinator?.eventOccurred(with: .buttonTappedEmojiList)
		
	}
	@objc func didTapAvatarList() {
		
		coordinator?.eventOccurred(with: .buttonTappedAvatarList)
		
	}
	
	@objc func didTapRepoiList() {
		
		coordinator?.eventOccurred(with: .buttonTappedRepoList)
		
	}
	
	
	
//	 var emojisList = [Emoji]()
	
	// 7- get all emojis from api
	
//	func getEmojis() {
//
//		let url = URL(string: "https://api.github.com/emojis")!
//
//			var request = URLRequest(url: url)
//
//			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//			let task = URLSession.shared.dataTask(with: url) { data, response, error in
//				if let data = data {
//					let json = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String,String>
//					if let array = json {
//						for (emojiName,emojiUrl) in array {
//							self.emojisList.append(Emoji (name: "\(emojiName)", url: "\(emojiUrl)"))
//						}					self.getRandomEmoji()
//					}
//				} else if let error = error {
//					print("HTTP Request Failed \(error)")
//				}
//			}
//
//			task.resume()
//		}
	//9- get random emojis
	
	@objc  func didTapRandomEmojiButton() {
		
			let randomNumber = Int.random(in: 0 ... (emojiStorage?.emojis.count ?? 0))
		 
		guard let emoji = emojiStorage?.emojis.item(at: randomNumber) else { return }
			
		// let urlEmojiImage = emoji.url
			
		let url = emoji.imageUrl
			downloadImage(from: url)
			
		}
		
}

//struct Emoji {
//	
//	var name: String
//	var url: String
//}

extension Array {
	func item(at: Int) -> Element? {
		
		count > at ? self[at] : nil
	}
}

extension MainPageViewControler: EmojiStorageDelegate {
	func emojiListUpdated() {
		didTapRandomEmojiButton()
	}
}

extension MainPageViewControler: AvatarStorageDelegate{
	
	func avatarListUpdate() {
		print("avatar: \(String(describing: avatarStorage?.avatar.count))")
	}
}
