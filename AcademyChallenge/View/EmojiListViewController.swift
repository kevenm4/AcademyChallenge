//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit


class EmojiListViewController: UIViewController, Coordinating {
	var coordinator: Coordinator?
	

	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .blue
		
		title = "Emoji List"
     
	}
	

}
