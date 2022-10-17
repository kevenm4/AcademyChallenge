//
//  LiveReposStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation

import UIKit
import CoreData



class LiveReposStorage {
	
	
	private	var reposNetwork: ReposNetwork = .init()
	
	
	private let persistence: ReposCoreData = .init()
	
	
	
	func fetchRepos (_ resultHandler: @escaping (Result<[Repos], Error>) -> Void){
		   var fetchedRepos : [NSManagedObject] = []
		   fetchedRepos = persistence.fetch()
		   
		   
		   if !fetchedRepos.isEmpty {
			   let repos = fetchedRepos.map({ item in
				   return Repos(full_name: item.value(forKey: "full_name") as! String, id: item.value(forKey: "id") as! Int, unique: item.value(forKey: "unique") as! Bool)
			   })
			   print(repos.count)
			   resultHandler(.success(repos))
			   
		   }else {
			   // METHOD IN EMOJI API
				   reposNetwork.executeNetwork(ReposAPI.getRepos) { (result: Result<[Repos], Error>) in
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
	
	
	
}
