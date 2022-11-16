//
//  ReposView.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 16/11/2022.
//

import Foundation
import UIKit

class ReposView: BaseGenericView {

    let tableView = UITableView()
    let loadSpinner: UIActivityIndicatorView = .init(style: .large)

    required init() {
        super.init()
        backgroundColor = .appColor(.primary)
        createSubViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createSubViews() {
        setUPtable()
        addToSuper()
        constrainis()
    }

    private func setUPtable() {
        tableView.frame = bounds
        tableView.backgroundColor = .clear
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = loadSpinner
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseCellIdentifier)
//        tableView.delegate = self
//        tableView.dataSource = self
    }

    private func addToSuper() {
      addSubview(tableView)
    }
    private func constrainis() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
