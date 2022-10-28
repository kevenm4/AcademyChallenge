//
//  RepoListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

class RepoListViewController: UIViewController {

    var viewModel: ReposListViewModel?

    var repoList: [Repos] = []

    let tableView = UITableView()

    let loadSpinner: UIActivityIndicatorView = .init(style: .large)

    var page: Int = 0

    var appleReposListRowHeigth: Int = 64

    var tofinished: Bool = true

    var isEnd: Bool = false

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = UIColor.appColor(.primary)
        setUPtable()
        addToSuper()
        constrainis()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        viewModel?.arrRepos.bind(listener: { [weak self] newArr in
            guard let newArr = newArr else {return}
            self?.repoList = newArr

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })

        viewModel?.end.bind(listener: { [weak self] ended in
            guard let ended = ended else {return}
            self?.isEnd = ended
        })
        viewModel?.fetchDataForTableView()
    }
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        if tableView.contentSize.height < tableView.frame.size.height {
            loadSpinner.startAnimating()
            viewModel?.fetchDataForTableView()
        }

    }
    private func setUPtable() {

        tableView.frame = view.bounds
        tableView.backgroundColor = .clear
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = loadSpinner
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

    }

    private func addToSuper() {

        view.addSubview(tableView)
    }

    private func constrainis() {

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RepoListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        self.tofinished = true
        return repoList.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: TableViewCell = tableView.dequeueReusableCell( for: indexPath)

        let styleText = repoList[indexPath.row].fullName

        cell.setUpCells(textField: styleText)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        print("cell tapped")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y

        let heightVisibleScroll = scrollView.frame.size.height
        let heightTable = scrollView.contentSize.height
        let heightCell = view.frame.height * 0.10

        if  offset > 0 && (offset + heightVisibleScroll + (heightCell)) > heightTable && tofinished && !isEnd {

            tofinished = false
            viewModel?.scrollTable()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            loadSpinner.stopAnimating()

        }
    }

}
