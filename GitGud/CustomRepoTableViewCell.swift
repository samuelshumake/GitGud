//
//  CustomRepoTableViewCell.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/7/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class CustomRepoTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var commitNumber: UILabel!
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var updatedLast: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
