//
//  GitVisualizerViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/4/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class GitVisualizerViewController: UIViewController {
    
    @IBOutlet weak var gitDraw: GitDraw!
    var repoInfo: Dictionary<String, Array<Commit>> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        gitDraw.repoInfo = repoInfo
        
    }
    
}



