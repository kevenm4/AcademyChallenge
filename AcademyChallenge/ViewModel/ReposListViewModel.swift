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
    var end: Box<Bool?> = Box(false)
    private var page: Int = 0
    func fetchDataForTableView() {
        self.page += 1
        reposService?.fetchRepos(page: page, size: Constants.AppleRepos.AppleReposPagination.perPage,
                                 { [weak self] (result: Result<[Repos], Error>) in

            switch result {
            case .success(let success):
                self?.arrRepos.value?.append(contentsOf: success)
//                DispatchQueue.main.async { [weak self] in
//                    // self?.tableView.reloadData()
//                }
            case .failure(let failure):
                print("Failure: \(failure)")
            }
        })
    }

    func scrollTable() {
        self.page += 1
        self.reposService?.fetchRepos(page: self.page,
                                      size: Constants.AppleRepos.AppleReposPagination.perPage,
                                      { ( result: Result<[Repos], Error>) in
            switch result {
            case .success(let success):
                self.arrRepos.value?.append(contentsOf: success)
                if success.count < Constants.AppleRepos.AppleReposPagination.perPage {
                    self.end.value = true
                }

            case .failure(let failure):
                print("[PREFETCH] Error : \(failure)")
            }
        })

    }
}
