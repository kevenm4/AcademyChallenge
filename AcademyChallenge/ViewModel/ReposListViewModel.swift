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
            .subscribe(onSuccess: { [weak self] result in

                guard let self = self else { return }

                self.arrRepos.append(contentsOf: result)
                if result.count < Constants.AppleRepos.perPage {
                    self.end.value = true
                }
                self.appleRepos.onNext(self.arrRepos)
            })
            .disposed(by: disposeBag)
}
}
