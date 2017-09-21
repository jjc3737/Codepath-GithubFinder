//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!
	
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    var repos: [GithubRepo]! = [GithubRepo]()
	
	let repoCellId = "repoCell"
	let segueToSetting = "showSetting"

    override func viewDidLoad() {
        super.viewDidLoad()
	
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
		
		// TableView
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension
    }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let repoCell = tableView.dequeueReusableCell(withIdentifier: repoCellId) as? RepoCell else {
			return UITableViewCell()
		}
		
		repoCell.prepare(with: repos[indexPath.row])
		
		return repoCell
	}
	
    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
			self.repos = [GithubRepo]()
            // Print the returned repositories to the output window
            for repo in newRepos {
				self.repos.append(repo)
                print(repo)
            }
			
			self.tableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
               
        })
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showSetting" {
			guard let settingNav = segue.destination as? UINavigationController,
				let settingsVC = settingNav.viewControllers.first as? SettingsController else {
				return
			}
			
			settingsVC.prepare(setting: searchSettings, settingHandler: { (settings) in
				self.searchSettings = settings
				self.doSearch()
			})
		}
	}
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
