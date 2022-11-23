//
//  ReposService.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 18/10/2022.
//

import Foundation
import RxSwift
protocol ReposService {
    func fetchRepos(page: Int, size: Int) -> Single<[Repos]>
}
