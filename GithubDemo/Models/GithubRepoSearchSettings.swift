//
//  GithubRepoSearchSettings.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

// Model class that represents the user's search settings
class GithubRepoSearchSettings {
    var searchString: String?
    var minStars = 0
	var showLanguages = false 
	let languages = ["Java", "JavaScript", "Objective-C", "Python", "Ruby", "Swift"]
    var includeLanguage = [true, true, true, true, true, true]
	
    init() {
        
    }
	
	func prepare(with minStars: Int, searchString: String?) {
		self.minStars = minStars
		self.searchString = searchString
	}
}
