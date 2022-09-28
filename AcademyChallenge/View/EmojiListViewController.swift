//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit


class EmojiListViewController: UIViewController, Coordinating {
	var coordinator: Coordinator?
	
	var collectionView: UICollectionView!
	var colors: [UIColor] = [.blue, .green, .red, .yellow, .black, .orange]
	
	init(){
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
		
	
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
		
		collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	

}
extension EmojiListViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return colors.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.color = colors[indexPath.row]
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
	
	


