//
//  RepoListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

class RepoListViewController: UIViewController{
	
	
	var reposService:ReposService?
	
	var repoList: [Repos] = []
	
	let tableView = UITableView()
	
	var page: Int = 1
	
	let strong = MockedDataSources()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.backgroundColor = UIColor.appColor(.primary)
		view.addSubview(tableView)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.delegate = self
		tableView.dataSource = strong
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		reposService?.fetchRepos(page: page, size: 10, { [weak self] (result: Result<[Repos],Error>) in
			
			switch result{
			case .success(let success):
				self?.repoList = success
				//self?.repoList.sorted()
				DispatchQueue.main.async { [weak self] in
					self?.tableView.reloadData()
				}
				
			case .failure(let failure):
				print("Failure: \(failure)")
			}
			

		})
		
		
	}
	
	
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
		
	}

	
	
}

extension RepoListViewController: UITableViewDelegate {
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		print("cell tapped")
	}
	
}


extension RepoListViewController: UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print(repoList.count)
		return repoList.count
	
	}
	
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.text = repoList[indexPath.row].fullName
		cell.backgroundColor = UIColor.appColor(.primary)
		cell.textLabel?.textColor = UIColor.appColor(.secondary)
		
		
		return cell
	}
	
	
	
	
	
}

extension RepoListViewController: UITableViewDataSourcePrefetching {
	
	func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
		
		page += 1
		
		reposService?.fetchRepos(page: page , size: 10, {( result: Result<[Repos], Error>) in
			switch result{
			
			case .success(let success):
				self.repoList.append(contentsOf: success)
				//self?.repoList.sorted()
				DispatchQueue.main.async { [weak self] in
					self?.tableView.reloadData()
				}
				
			case .failure(let failure):
				print("Failure: \(failure)")
			}
	})
		
		
	}
	
	
	func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
		print("the giant is lost")
	}
	
	
	
	
}






class MockedDataSources:  NSObject, UITableViewDataSource {
	
	
	var repoMock : MockRepos = .init()
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return repoMock.appleRepos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.text = repoMock.appleRepos[indexPath.row].fullName
		cell.backgroundColor = UIColor.appColor(.primary)
		cell.textLabel?.textColor = UIColor.appColor(.secondary)
		
		
		return cell
		
	}
	
		
	}
