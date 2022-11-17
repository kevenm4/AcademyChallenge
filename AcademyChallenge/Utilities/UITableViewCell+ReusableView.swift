//
//  UITableViewCell+ReusableView.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 25/10/2022.
//

import Foundation
import UIKit

extension UITableViewCell: ReusableView {}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseCellIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}
