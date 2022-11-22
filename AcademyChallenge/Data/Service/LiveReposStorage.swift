//
//  LiveReposStorage.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 17/10/2022.
//

import Foundation

import UIKit
import CoreData
//
import RxSwift
class LiveReposStorage: ReposService {
    private	var reposNetwork: Network = .init()
    // private let persistence: ReposCoreData = .init()
    func fetchRepos(page: Int, size: Int) -> Single<[Repos]> {        
        return reposNetwork.rx.executeNetworkCall(ReposAPI.getRepos(perPage: size, page: page))
    }
}
