//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit


class EmojiListViewController: UIViewController, Coordinating, EmojiPresenter {
	
	var coordinator: Coordinator?
	var emojiStorage: EmojiStorage?
	
	var colors: [UIColor] = [.blue, .green, .red, .yellow, .black, .orange]
	
	lazy var collectionView: UICollectionView = {
			let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
			return v
		}()
	
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
			URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
		}

		func downloadImage(url: URL, imageView: UIImageView){
			getData(from: url) { data, response, error in
				guard let data = data, error == nil else { return }
				// always update the UI from the main thread
				DispatchQueue.main.async() {
					imageView.image = UIImage(data: data)
				}
			}
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
extension EmojiListViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}

extension EmojiListViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		let countEmojis = emojiStorage?.emojis.count ?? 0
		return countEmojis
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
			return UICollectionViewCell()
		}
		//cell.color = colors[indexPath.row]
		let url = URL(string: (emojiStorage?.emojis[indexPath.row].url)!)!
			   
			   let imageView : UIImageView = .init(frame: .zero)
			   
			   downloadImage(url: url, imageView: imageView)
			   
			   cell.contentView.addSubview(imageView)
			   
			   imageView.translatesAutoresizingMaskIntoConstraints = false
			   
			   NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
											imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor)])
		return cell
	}
}

extension EmojiListViewController: EmojiStorageDelegate {
	func emojiListUpdated() {
		print("Emojis: \(String(describing: emojiStorage?.emojis.count))")
				collectionView.reloadData()
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
	
	


