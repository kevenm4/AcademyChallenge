//
//  CollectionViewCell.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 28/09/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	
	private var emojiImageView: UIImageView
	var dataTask: URLSessionTask?
	
	override init(frame: CGRect) {
		
		emojiImageView = .init(frame: .zero)
		emojiImageView.contentMode = .scaleAspectFit
		emojiImageView.clipsToBounds = true
		
		super.init(frame: .zero)
		self.contentView.addSubview(emojiImageView)
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func setUpCell(url: URL){
		self.emojiImageView.downloadImageFromURL(from: url)
	}
	
	func setupConstraints(){
		emojiImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			emojiImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
					  emojiImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
					  emojiImageView.topAnchor.constraint(equalTo: self.topAnchor),
					  emojiImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		
		])
	}
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		dataTask?.cancel()
		
		emojiImageView.image = nil
	
	}
}

