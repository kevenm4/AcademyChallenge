//
//  ReusableView.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 25/10/2022.
//

import Foundation

protocol ReusableView {
    
    static var reuseCellIdentifier: String {get}
    
}

extension ReusableView {
    
    static var reuseCellIdentifier: String {
        // the "describring: self" here will make the reuseIdentifier the class name
        return String(describing: self)
    }
}
