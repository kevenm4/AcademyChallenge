//
//  RepoListCoordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 07/10/2022.
//

import Foundation
import UIKit


class RepoListCoordinator: Coordinator {
	
	
	
	private let presenter : UINavigationController
	
	private var repoListViewControler: RepoListViewController?
	
	init(presenter: UINavigationController){
		
		self.presenter = presenter
	}
	func start() {
		
		let repoListViewController = RepoListViewController()
		presenter.pushViewController(repoListViewController, animated: true)
		repoListViewController.reposService = reposService
		self.repoListViewControler = repoListViewController
	}
	
}
