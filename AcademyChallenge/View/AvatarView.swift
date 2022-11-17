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
        // collectionView.delegate = self
    }
}

// extension AvatarView: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
//    }
//
//    func collectionView (_ collectionView: UICollectionView,
//                         layout collectionViewLayout: UICollectionViewLayout,
//                         sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard  let layout = collectionViewLayout as? UICollectionViewFlowLayout else {return .zero}
//        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
//        return CGSize(width: widthPerItem - 8, height: widthPerItem)
//
//    }
// }
