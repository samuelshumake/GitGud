//
//  RepoPicker.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/17/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

struct Repos {
    var name: String
    var created: String
    var pushed: String
    var branchDefault: String
}

class RepoPickerCell: UITableViewCell {
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var updatedDate: UILabel!
    @IBOutlet weak var repoButton: UIButton!
}

class RepoPicker: UITableView {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
