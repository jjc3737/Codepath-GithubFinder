//
//  LanguageSwitchCell.swift
//  GithubDemo
//
//  Created by Jaehee Chung on 9/4/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class LanguageSwitchCell: UITableViewCell {
	
	@IBOutlet var languageSwitch: UISwitch!
	var switchHandler: (Bool) -> Void = { (isOn: Bool) in }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	@IBAction func onSwitchChanged(_ sender: UISwitch) {
		switchHandler(sender.isOn)
	}
}
