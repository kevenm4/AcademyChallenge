//
//  Emoji.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 29/09/2022.
//

import Foundation
import UIKit

struct Emoji {
	
	var name: String
	var url: String
}


extension Emoji : Comparable {
	
	static func < (lhs: Emoji, rhs: Emoji) -> Bool {
		lhs.name < rhs.name
	}
}
