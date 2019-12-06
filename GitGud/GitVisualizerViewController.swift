//
//  GitVisualizerViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/4/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class GitVisualizerViewController: UIViewController {
    
//    var gitScroll: UIScrollView!
//    var gitDraw: UIView!
    
    @IBOutlet weak var gitDraw: GitDraw!
    var repoInfo: Dictionary<String, Array<Commit>> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gitDraw.repoInfo = repoInfo
//
//        gitDraw = UIView()
//        gitScroll = UIScrollView(frame: view.bounds)
//
//        gitScroll.backgroundColor = UIColor.blue
//        gitScroll.contentSize = gitDraw.bounds.size
//        gitScroll.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
//        gitScroll.addSubview(gitDraw)
//        view.addSubview(gitScroll)
        
        
        
        
    }
    
}



