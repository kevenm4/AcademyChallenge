//
//  ReposListViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 27/10/2022.
//

import Foundation
//
import RxSwift

class ReposListViewModel {
    var reposService: ReposService?
    var arrRepos: Box<[Repos]?> = Box([])
    var end: Box<Bool?> = Box(false)
    private var page: Int = 0

    func fetchDataForTableView()-> Observable<[Repos]> {
        guard let reposService = reposService else {

            return Observable<[Repos]>.never()

        }

        self.page += 1
        return reposService.fetchRepos(page: self.page, size: Constants.AppleRepos.AppleReposPagination.perPage)
    }

    func scrollTable() {

    }
}
