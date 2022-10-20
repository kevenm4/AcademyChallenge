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
	
	
	private let persistence: ReposCoreData = .init()
	
	
	func fetchRepos(page:Int , size:Int,_ resultHandler: @escaping (Result<[Repos], Error>) -> Void) {
		
		var fetchedRepos : [NSManagedObject] = []
		fetchedRepos = persistence.fetch()
		
		
		if !fetchedRepos.isEmpty {
			let repos = fetchedRepos.map({ item in
				return Repos(id: item.value(forKey: "id") as! Int, fullName: item.value(forKey: "fullName") as! String, unique: item.value(forKey: "unique") as! Bool)
			})
			print(repos.count)
			resultHandler(.success(repos))
			
		}else {
			// METHOD IN EMOJI API
				reposNetwork.executeNetworkCall(ReposAPI.getRepos(perPage: size, page: page)) { (result: Result<[Repos], Error>) in
					switch result{
					case .success(let success):
						resultHandler(.success(success))
					case .failure(let failure):
						print("Failure: \(failure)")
						resultHandler(.failure(failure))
					}
				}
		}
		
	}
	
	
	
//	private	var reposNetwork: Network = .init()
//
//
//	private let persistence: ReposCoreData = .init()
//
//
	
//	func fetchRepos (page:Int , size:Int,_ resultHandler: @escaping (Result<[Repos], Error>) -> Void){
//		   var fetchedRepos : [NSManagedObject] = []
//		   fetchedRepos = persistence.fetch()
//
//
//		   if !fetchedRepos.isEmpty {
//			   let repos = fetchedRepos.map({ item in
//				   return Repos(id: item.value(forKey: "id") as! Int, fullName: item.value(forKey: "fullName") as! String, unique: item.value(forKey: "unique") as! Bool)
//			   })
//			   print(repos.count)
//			   resultHandler(.success(repos))
//
//		   }else {
//			   // METHOD IN EMOJI API
//				   reposNetwork.executeNetworkCall(ReposAPI.getRepos(perPage: size, page: page)) { (result: Result<[Repos], Error>) in
//					   switch result{
//					   case .success(let success):
//						   resultHandler(.success(success))
//					   case .failure(let failure):
//						   print("Failure: \(failure)")
//						   resultHandler(.failure(failure))
//					   }
//				   }
//		   }
//
//	   }
	
	
	
}
