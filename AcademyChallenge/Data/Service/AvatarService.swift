//
//  AvatarService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 12/10/2022.
//

import Foundation

protocol AvatarService {
	
	func fetchAvatar(_ resultHandler: @escaping (Result<[Avatar],Error>) -> Void)
	
}
