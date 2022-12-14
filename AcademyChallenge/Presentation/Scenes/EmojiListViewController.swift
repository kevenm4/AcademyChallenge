//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit


class EmojiListViewController: UIViewController {
	
	var emoji: [Emoji]?
	
	//var strong = MockedDataSource()
	
	weak var emojiService: EmojiService?
	
	//var emojiServer: LiveEmojiStorage?
	
	lazy var collectionView: UICollectionView = {
			let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
			return v
		}()
	
	
		
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        setUpViews()
		addViewToSuperview()
		setUpConstrains()
		
	}
	private func setUpViews() {
		
		setUpCollecionView()
	}
	

	private func addViewToSuperview(){
		
		view.addSubview(collectionView)
	}
	
	private func setUpConstrains() {
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		
		
		])
	}
	
	private func setUpCollecionView() {
		
	
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		
		layout.minimumLineSpacing = 8
		layout.minimumInteritemSpacing = 4
		
		collectionView = .init(frame: .zero, collectionViewLayout: layout)
		
		collectionView.backgroundColor = UIColor.appColor(.primary)
		
		collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewDidAppear(animated)
		
		emojiService?.fetchEmojis({ [weak self] (result: Result<[Emoji],Error>) in
			switch result{
			case .success(let success):
				self?.emoji = success
				self?.emoji?.sort()
				DispatchQueue.main.async { [weak self] in
					self?.collectionView.reloadData()
				}
				
			case .failure(let failure):
				print("Failure: \(failure)")
			}
			

		})
		
		
	}
	
	

}





extension EmojiListViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		let countEmojis = emoji?.count ?? 0
		return countEmojis
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
			
			return UICollectionViewCell()
		}
		
	guard let url = emoji?[indexPath.row].imageUrl else {return UICollectionViewCell()}

		cell.setUpCell(url: url)
			   

		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

				  let emojis = self.emoji?[indexPath.row]
				  
				  self.emojiService?.deleteEmoji(emojiToDelete: emojis!)
				  
				  self.emoji?.remove(at: indexPath.row)
				  
				  collectionView.reloadData()

	   }
	
	   }


class MockedDataSource:  NSObject, UICollectionViewDataSource {
	
	var emojiMock : MockEmojis = .init()
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return emojiMock.emojis.count
	}
	
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
			
			return UICollectionViewCell()
		}
		
		cell.setUpCell(url: emojiMock.emojis[indexPath.row].imageUrl)

			

			return cell
		}
		
	}
	

	


extension EmojiListViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
				  layout collectionViewLayout: UICollectionViewLayout,
				  insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
	}
	
	
	func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		let layout = collectionViewLayout as! UICollectionViewFlowLayout
		
		let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
		
		return CGSize(width: widthPerItem - 8, height: widthPerItem)
		
	}

}
	


