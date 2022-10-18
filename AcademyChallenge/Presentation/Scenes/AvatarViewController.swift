//
//  AvatarViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

class AvatarViewController: UIViewController {
	
	
	
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
		
		collectionView.register(AvatarViewCell.self, forCellWithReuseIdentifier: "cell")
		
//		collectionView.delegate = self
//		collectionView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
	}
    
}



//extension AvatarViewController: UICollectionViewDataSource {
//
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//	//	let countAvatar = avatarStorage?.avatar.count ?? 0
//		//return countAvatar
//	}
//
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AvatarViewCell else {
//
//			return UICollectionViewCell()
//		}
//
//	//	guard let url = avatarStorage?.avatar[indexPath.row].avatar_url else {return UICollectionViewCell()}
//
//		//cell.setUpCell(url: url)
//
//
//		return cell
//	}
//}
//
//extension AvatarViewController: UICollectionViewDelegateFlowLayout {
//
//	func collectionView(_ collectionView: UICollectionView,
//				  layout collectionViewLayout: UICollectionViewLayout,
//				  insetForSectionAt section: Int) -> UIEdgeInsets {
//
//		return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
//	}
//
//
//	func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//	{
//		let layout = collectionViewLayout as! UICollectionViewFlowLayout
//
//		let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
//
//		return CGSize(width: widthPerItem - 8, height: widthPerItem)
//



