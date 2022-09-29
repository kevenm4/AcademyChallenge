//
//  CollectionViewCell.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 28/09/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	var color: UIColor = .white {
		didSet {
			backgroundColor = color
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.backgroundColor = .clear
	}
}

