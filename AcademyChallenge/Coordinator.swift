//
//  Coordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit

enum Event {
	
	case buttonTappedEmojiList
	case buttonTappedAvatarList
	case buttonTappedRepoList
	
}
protocol Coordinator{
	var navigationController: UINavigationController? {get set}
	
	func eventOccurred(with type: Event)
	func start()
}

protocol Coordinating {
	var coordinator : Coordinator? {get set}
}
