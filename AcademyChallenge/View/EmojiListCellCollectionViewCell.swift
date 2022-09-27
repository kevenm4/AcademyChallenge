//
//  EmojiListCellCollectionViewCell.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 27/09/2022.
//

import UIKit

class EmojiListCellCollectionViewCell: UICollectionViewCell {
    
	private var imageView: UIImageView
	
	override init(frame: CGRect) {
		
		imageView = .init(frame: .zero)
		super.init(frame: frame)
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	
	func setup(image: UIImage){
		imageView.image = image
	}
	
}
