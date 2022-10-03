//
//  AvatarViewCell.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import UIKit

class AvatarViewCell: UICollectionViewCell {
	
	private var avatarImageView: UIImageView
	var dataTasks: URLSession?
	
	override init(frame: CGRect) {
		
		avatarImageView = .init(frame: .zero)
		avatarImageView.contentMode = .scaleAspectFit
		avatarImageView.clipsToBounds = true
		
		super.init(frame: .zero)
		self.contentView.addSubview(avatarImageView)
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
