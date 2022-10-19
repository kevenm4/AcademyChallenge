//
//  AvatarViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

class AvatarViewController: UIViewController {
	
	var avatarService: LiveAvatarStorage?
	var avatarList: [Avatar] = []
	
	
	lazy var collectionView: UICollectionView = {
			let s = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
			return s
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
		avatarService?.fetchAvatarList({ (result: [Avatar]) in
			self.avatarList = result
		})
		collectionView.reloadData()
		
	}
    
}



extension AvatarViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		let countAvatar = avatarList.count
		
		return countAvatar
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {

			return UICollectionViewCell()
		}

		let url = avatarList[indexPath.row].avatar_url
		cell.setUpCell(url: url)


		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		   
		let alert = UIAlertController(title: "Delete Avatar", message: "Are you sure you want delete ?", preferredStyle: .alert)
			  
			  alert.addAction(UIAlertAction(title: "Cancel", style: .default))
			  
			  alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(_: UIAlertAction!) in
				  
				  let avatar = self.avatarList[indexPath.row]
				  
				  self.avatarService?.deleteAvatar(avatarToDelete: avatar)
				  
				  self.avatarList.remove(at: indexPath.row)
				  
				  collectionView.reloadData()
				  
			  }))
			  
			  self.present(alert, animated: true, completion: nil)


	   }
}

extension AvatarViewController: UICollectionViewDelegateFlowLayout {

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
