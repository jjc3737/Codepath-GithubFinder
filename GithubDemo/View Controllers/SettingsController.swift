//
//  SettingsController.swift
//  GithubDemo
//
//  Created by Jane Chung on 8/29/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet var tableView: UITableView!
	
	fileprivate var setting: GithubRepoSearchSettings = GithubRepoSearchSettings.init()
	fileprivate var settingsHandler: (GithubRepoSearchSettings) -> Void = { (settings) in }
	
	let minStarScale: Float = 100000
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	func prepare(setting: GithubRepoSearchSettings?, settingHandler: @escaping (GithubRepoSearchSettings) -> Void) {
		if let setting = setting {
			self.setting = setting
		}
		self.settingsHandler = settingHandler
	}

	@IBAction func sliderChanged(_ sender: UISlider) {
		
		
	}

	@IBAction func saveTapped(_ sender: UIBarButtonItem) {
		settingsHandler(setting)
		dismiss(animated: true, completion: nil)
	}
	
	
	@IBAction func cancelTapped(_ sender: UIBarButtonItem) {
		
		dismiss(animated: true, completion: nil)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0, 1:
			return 1
		case 2:
			return setting.showLanguages ? 6 : 0
		default:
			return 0
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch section {
		case 0, 1:
			return 40
		default:
			return 0
		}
	}
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let normalTableViewCell = UITableViewCell()
		switch indexPath.section {
		case 0:
			guard let minStarCell = tableView.dequeueReusableCell(withIdentifier: "minStarCell") as? MinStarCell else {
				return normalTableViewCell
			}
			minStarCell.starSlider.value = Float(setting.minStars) / minStarScale
			minStarCell.minStarCount.text = String(setting.minStars)
			minStarCell.sliderChanged = { (slider: UISlider) in
				self.setting.minStars = Int(slider.value * self.minStarScale)
				minStarCell.minStarCount.text = String(self.setting.minStars)
			}
			return minStarCell
		case 1:
			guard let languageSwitchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? LanguageSwitchCell else {
				return normalTableViewCell
			}
			languageSwitchCell.languageSwitch.isOn = setting.showLanguages
			languageSwitchCell.switchHandler = { (isOn)  in
				self.setting.showLanguages = isOn
				self.tableView.reloadData()
			}
			return languageSwitchCell
		case 2:
			
			guard let languageCell = tableView.dequeueReusableCell(withIdentifier: "language") as? LanguageCell else {
				return normalTableViewCell
			}
			languageCell.languageName.text = setting.languages[indexPath.row]
			languageCell.accessoryType = setting.includeLanguage[indexPath.row] ? .checkmark : .none
			return languageCell
		default:
			return normalTableViewCell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section != 2 {
			return
		}
		
		guard let languageCell = tableView.cellForRow(at: indexPath) as? LanguageCell else {
			return
		}
		
		languageCell.isSelected = false
		
		let isIncluded = languageCell.accessoryType == .checkmark
		languageCell.accessoryType = isIncluded ? .none : .checkmark
		setting.includeLanguage[indexPath.row] = !isIncluded
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


