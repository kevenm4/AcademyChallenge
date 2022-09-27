//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit
import Alamofire
class EmojiListViewController: UIViewController, Coordinating, UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		<#code#>
	}
	
	
	
	var coordinator: Coordinator?
	
	private var collectionEmojis : UICollectionView?
	private var emojisList : [String : String] = [:]
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
//		let request = AF.request("https://api.github.com/emojis")
//
//		request.responseJSON{(data) in
//
//
//			print(data)
//			print(data.data?.count)
//		}
		getAllEmojis()
		view.backgroundColor = .blue
		
		title = "Emoji List"
       let layout = UICollectionViewFlowLayout()
		
		layout.scrollDirection = .vertical
		
		collectionEmojis = UICollectionView (frame: .zero, collectionViewLayout: layout)
		guard let collectionEmojis = collectionEmojis else {
			return
		}
		collectionEmojis.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionEmojis.dataSource = self
		collectionEmojis.delegate = self
		view.addSubview(collectionEmojis)
		collectionEmojis.frame = view.bounds
		collectionEmojis.reloadData()
    }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return emojisList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> EmojiListCellCollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmojiListCellCollectionViewCell
		cell.setup(image: <#T##UIImage#>)
		

		return cell
	}
	func getAllEmojis(){
		let url = URL(string: "https://api.github.com/emojis")!

		var request = URLRequest(url: url)

		print(request)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let data = data {
				let json = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String,String>
		//        print(json!)
		//        print(data)
				//print(String(data: data, encoding: .utf8))
				if let array = json {
					print(array.count)
						self.emojisList = array
//					for (emojiName,emojiUrl) in array {
//						print("Item \(emojiName): URL: \(emojiUrl)\n")
//					}
				}
				//print(String(data: data, encoding: .utf8))
			} else if let error = error {
				print("HTTP Request Failed \(error)")
			}
		}

		task.resume()
	}

}
