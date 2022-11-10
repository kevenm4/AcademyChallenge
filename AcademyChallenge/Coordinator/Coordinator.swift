//
//  Coordinator.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var chillCoordinators: [Coordinator] { get set }
	func start()

}
