//
//  BaseGenericViewModel.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/11/2022.
//

import Foundation
import UIKit
//
import RxSwift

class BaseGenericView: UIView {

    var disposeBag = DisposeBag()

    required init() {
        super.init(frame: .zero)
        setupView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {}
}
