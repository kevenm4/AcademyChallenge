//
//  MockAvatarService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 19/10/2022.
//

import Foundation


class MockReposService: ReposService {
	
	private var mockedrepos: MockRepos  = .init()
	private let mocks: [Repos]
	
	init() {
		
		mocks = mockedrepos.appleRepos
		
	}
	
	func fetchRepos(page:Int , size:Int,_ resultHandler: @escaping (Result<[Repos], Error>) -> Void) {
		var repos: [Repos] = []
		let endIndex = size * page
		let startIndex = endIndex - size
		
		if endIndex <= mocks.count {
			repos = Array<Repos>(mocks[startIndex...endIndex-1])
		}
			
	
	resultHandler(.success(repos))
		}
		
}


	
	

