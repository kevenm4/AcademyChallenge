//
//  AvatarView.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/11/2022.
//

import Foundation
import UIKit
//
import RxSwift
import RxCocoa
class AvatarView: BaseGenericView {
    lazy var collectionView: UICollectionView = {
        let sCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return sCollection
    }()
    required init() {
        super.init()
        createSubView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createSubView() {
        setUpViews()
        addViewToSuperview()
        setUpConstrains()
    }
    private func setUpViews() {
        setUpCollecionView()
    }
    private func addViewToSuperview() {
        addSubview(collectionView)
    }
    private func setUpConstrains() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    private func setUpCollecionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.appColor(.primary)
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: CollectionViewCell.reuseCellIdentifier)

    }

    func createDeleteAlert(_ deleteFunction: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Delete Avatar",
                                      message: "Are you sure you want delete ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(_: UIAlertAction!) in

            deleteFunction()

        }))
        return alert
    }
}

