//
//  CollectionViewCell.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 28/09/2022.
//

import UIKit
//
import RxSwift

class CollectionViewCell: UICollectionViewCell {

	 var imageView: UIImageView
	var dataTask: URLSessionTask?
    var reusableDisposeBag = DisposeBag()

	override init(frame: CGRect) {

		imageView = .init(frame: .zero)
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true

		super.init(frame: .zero)
		self.contentView.addSubview(imageView)
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setUpCell(viewModel: EmojiListViewModel) {
	}

	func setupConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
					  imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
					  imageView.topAnchor.constraint(equalTo: self.topAnchor),
					  imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

		])
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		dataTask?.cancel()
		imageView.image = nil
        reusableDisposeBag = DisposeBag()

	}
}
