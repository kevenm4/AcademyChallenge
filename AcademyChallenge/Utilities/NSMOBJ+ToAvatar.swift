//
//  NSMOBJ+ToAvatar.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 14/10/2022.
//

import Foundation

import CoreData

extension NSManagedObject {
	func ToAvatar() -> Avatar{
		return Avatar(
			login: self.value(forKey: "login") as! String,
			id: self.value(forKey: "id") as! Int,
			avatarUrl: URL(string: self.value(forKey: "avatarUrl") as! String)!)
	}
}
