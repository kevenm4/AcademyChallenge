//
//  BaseGenericViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/11/2022.
//

import Foundation
import UIKit
//
import RxSwift

class BaseGenericViewController<View: BaseGenericView>: UIViewController {
    
    var disposeBag = DisposeBag()
    
    var genericView: View {
        
        // swiftlint:disable:next force_cast
        view as! View
    }
    
    override func loadView() {
        view = View()
    }
}
