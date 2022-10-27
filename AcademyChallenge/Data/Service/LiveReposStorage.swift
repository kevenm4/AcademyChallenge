//
//  LiveReposStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation

import UIKit
import CoreData

class LiveReposStorage: ReposService {

	private	var reposNetwork: Network = .init()

	// private let persistence: ReposCoreData = .init()

	func fetchRepos(page: Int, size: Int, _ resultHandler: @escaping (Result<[Repos], Error>) -> Void) {

				reposNetwork.executeNetworkCall(ReposAPI.getRepos(perPage: size, page: page)) { (result: Result<[Repos], Error>) in
					switch result {
					case .success(let success):
						resultHandler(.success(success))
					case .failure(let failure):
						print("Failure: \(failure)")
						resultHandler(.failure(failure))
					}
				}
		}

	}

