//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Jane Chung on 8/29/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

	@IBOutlet weak var repoName: UILabel!
	@IBOutlet weak var owner: UILabel!
	@IBOutlet weak var repoImage: UIImageView!
	@IBOutlet weak var forkCount: UILabel!
	@IBOutlet weak var repoDescription: UILabel!
	@IBOutlet weak var starCount: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func prepare(with repo: GithubRepo) {
		if let name = repo.name {
			repoName.text = name
		}
		
		if let handle = repo.ownerHandle {
			owner.text = handle
		}
		
		if let imageUrlString = repo.ownerAvatarURL, let imageUrl = URL(string: imageUrlString) {
			repoImage.setImageWith(imageUrl)
		}
		//Remember to set placeholder image in storyboard and here 
		
		if let repoDesc = repo.repoDescription {
			repoDescription.text = repoDesc
		}
		
		if let forkCt = repo.forks {
			forkCount.text = String(forkCt)
		}
		
		if let starCt = repo.stars {
			starCount.text = String(starCt)
		}
	}

}
