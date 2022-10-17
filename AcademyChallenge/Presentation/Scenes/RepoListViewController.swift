//
//  RepoListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

class RepoListViewController: UIViewController{
	
	
	var reposService: LiveReposStorage?
	var repoList: [Repos] = []
	
	let tableView = UITableView()
	
	var data = [String]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Repo List"
		
		for x in 0...100 {
			
			data.append("keven is gigant \(x)")
		}
		view.backgroundColor = UIColor.appColor(.primary)
		view.addSubview(tableView)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.delegate = self
		tableView.dataSource = self
		
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
		
		return data.count
	}
	
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.text = data[indexPath.row]
		//avatarList[indexPath.row].avatar_url
		return cell
	}
	
	
	
}
