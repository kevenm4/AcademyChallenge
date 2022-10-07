//
//  AvatarViewCell.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import UIKit

class AvatarViewCell: UICollectionViewCell {
	
	private var avatarImageView: UIImageView
	var dataTask: URLSessionTask?
	
	override init(frame: CGRect) {
		
		avatarImageView = .init(frame: .zero)
		avatarImageView.contentMode = .scaleAspectFit
		avatarImageView.clipsToBounds = true
		
		super.init(frame: .zero)
		self.contentView.addSubview(avatarImageView)
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUpCell(url: URL){
		downloadImage(from: url)
	}
	
	func setupConstraints(){
		
		avatarImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
					  avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
					  avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
					  avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		
		])
	}
	
	
	
	
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		
		  dataTask?.cancel()
		
		   dataTask = Application.urlSession?.dataTask(with: url, completionHandler: completion)
		
		   dataTask?.resume()
	   }
	
	
	func downloadImage(from url: URL) {
		getData(from: url) { [weak self] data, response, error in
			if let error = error {
				DispatchQueue.main.async() {
					
					self?.avatarImageView.image = nil
					
					self?.dataTask = nil
				}
				return
			}
			DispatchQueue.main.async() { () in
				
				self?.avatarImageView.image = nil
				
				self?.dataTask = nil
				
				guard let data = data, error == nil else { return }
				
 
				self?.avatarImageView.image = UIImage(data: data)
			}
		}
	}
	override func prepareForReuse() {
		dataTask?.cancel()
		
		avatarImageView.image = nil
	}
	
}
