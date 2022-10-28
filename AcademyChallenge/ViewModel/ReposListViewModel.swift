//
//  ReposListViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 27/10/2022.
//

import Foundation

class ReposListViewModel {
    var reposService: ReposService?
    var arrRepos: Box<[Repos]?> = Box([])
    private var page: Int = 0
    func fetchDataForTableView() {
        self.page += 1
        reposService?.fetchRepos(page: page, size: Constants.AppleRepos.AppleReposPagination.perPage,
                                 { [weak self] (result: Result<[Repos], Error>) in

            switch result {
            case .success(let success):
                self?.arrRepos.value?.append(contentsOf: success)
                DispatchQueue.main.async { [weak self] in
                    // self?.tableView.reloadData()
                }
            case .failure(let failure):
                print("Failure: \(failure)")
            }
        })
    }
}
