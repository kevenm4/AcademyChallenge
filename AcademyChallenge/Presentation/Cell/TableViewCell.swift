//
//  TableViewCell.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 25/10/2022.
//

import UIKit

class TableViewCell: UITableViewCell {

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setUpCells(textField: String) {

		let splittedString = textField.split(separator: "/")

		self.textLabel?.text = String(splittedString[splittedString.count-1])
		self.backgroundColor = .clear

		self.textLabel?.textColor = UIColor.appColor(.secondary)

	}

}
