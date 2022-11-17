//
//  ColorSet.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 10/10/2022.
//

import UIKit

enum AssetsColor: String {
    
    case primary
    case secondary
}

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
