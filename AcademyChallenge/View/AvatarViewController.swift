//
//  AvatarViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

class AvatarViewController: UIViewController, Coordinating, AvatarPresenter {
	var avatarStorage: AvatarStorage?
	
	var coordinator: Coordinator?
	
	lazy var collectionView: UICollectionView = {
			let s = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
			return s
		}()

    override func viewDidLoad() {
        super.viewDidLoad()
	
    }
    

    
}

extension AvatarViewController: AvatarStorageDelegate {
	func avatarListUpdate() {
		print("avatar: \(String(describing: avatarStorage?.avatar.count))")
				collectionView.reloadData()
	}
	
}

