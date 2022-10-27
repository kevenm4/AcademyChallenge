//
//  ReposService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 18/10/2022.
//

import Foundation

protocol ReposService {

	func fetchRepos(page: Int, size: Int, _ resultHandler: @escaping (Result<[Repos], Error>) -> Void)

}
