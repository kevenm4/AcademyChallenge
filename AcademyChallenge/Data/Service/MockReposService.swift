//
//  MockAvatarService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 19/10/2022.
//

import Foundation


class MockReposService: ReposService {
	
	private var mockedrepos: MockRepos  = .init()
	
	func fetchRepos(page:Int , size:Int,_ resultHandler: @escaping (Result<[Repos], Error>) -> Void) {
		resultHandler(.success(mockedrepos.appleRepos))
	}

	
	
}
