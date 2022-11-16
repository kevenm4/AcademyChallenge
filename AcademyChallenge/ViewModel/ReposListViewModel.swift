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
    var arrRepos: [Repos] = []
    var end: Box<Bool?> = Box(false)
    private var page: Int = 0
let size =  Constants.AppleRepos.perPage
    private var appleRepos: PublishSubject<[Repos]> = PublishSubject()
    var appleReposReturn: Observable<[Repos]> { appleRepos.asObservable() }
    let disposeBag = DisposeBag()

    func fetchDataForTableView() {
        guard let reposService = reposService else {
            return
        }

        self.page += 1

         reposService.fetchRepos(page: page, size: size)
            .flatMap { result -> Observable<[Repos]> in
                self.arrRepos.append(contentsOf: result)
                return Observable<[Repos]>.just(self.arrRepos)
            }
            .subscribe(appleRepos)
            .disposed(by: disposeBag)
    }
}
