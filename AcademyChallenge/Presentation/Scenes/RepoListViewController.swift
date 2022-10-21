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
	var perPage: Int = 10
	var appleReposListRowHeigth: Int = 64
	
	var tofinished : Bool = true
	
	var isEnd: Bool = false
	
	
	let strong = MockedDataSources()
	override func viewDidLoad() {
		
		
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.appColor(.primary)
		setUPtable()
		addToSuper()
		constrainis()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		reposService?.fetchRepos(page: page, size: perPage, { [weak self] (result: Result<[Repos],Error>) in
			
			switch result{
			case .success(let success):
				self?.repoList = success
				DispatchQueue.main.async { [weak self] in
					self?.tableView.reloadData()
				}
				
			case .failure(let failure):
				print("Failure: \(failure)")
			}
			
			
		})
		
		
	}
	
	
	
	
	
	
	private func setUPtable() {
		
		tableView.frame = view.bounds
		tableView.backgroundColor = .clear
		tableView.automaticallyAdjustsScrollIndicatorInsets = false
		tableView.contentInsetAdjustmentBehavior = .never
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.delegate = self
		tableView.dataSource = self
		
	}
	
	private func addToSuper(){
		
		view.addSubview(tableView)
	}
	
	private func constrainis(){
		
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.text = repoList[indexPath.row].fullName
		cell.backgroundColor = .clear
		cell.textLabel?.textColor = UIColor.appColor(.secondary)
		
		
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
		let heightCell = CGFloat(appleReposListRowHeigth * 4)
		
		
		if( offset > 0 && (offset + heightVisibleScroll + (heightCell)) > heightTable && tofinished && !isEnd) {
			
			tofinished = false
			self.page += 1
			self.reposService?.fetchRepos(page: self.page, size: perPage, { ( result: Result<[Repos], Error>) in
				switch result {
				case .success(let success):
					self.repoList.append(contentsOf: success)
					
					DispatchQueue.main.async { [weak self] in
						self?.tableView.reloadData()
					}
					
					if success.count < self.perPage {
						self.isEnd = true
					}
					
				case .failure(let failure):
					print("[PREFETCH] Error : \(failure)")
				}
			})
		}
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
