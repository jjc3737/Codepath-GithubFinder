//
//  MinStarCell.swift
//  GithubDemo
//
//  Created by Jaehee Chung on 9/21/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class MinStarCell: UITableViewCell {

	@IBOutlet var starSlider: UISlider!
	@IBOutlet var minStarCount: UILabel!
	
	var sliderChanged: (UISlider) -> Void = { (slider: UISlider) in }
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	@IBAction func sliderChanged(_ sender: UISlider) {
		sliderChanged(sender)
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
