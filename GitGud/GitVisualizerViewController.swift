//
//  GitVisualizerViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/4/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class GitVisualizerViewController: UIViewController {
    
    @IBOutlet var pinchRecognizer: UIPinchGestureRecognizer!
    @IBOutlet weak var gitDraw: GitDraw!
    var repoInfo: Dictionary<String, Array<Commit>> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        gitDraw.repoInfo = repoInfo
        
    }
    
    @IBAction func pinchZoom(_ sender: UIPinchGestureRecognizer) {
        if pinchRecognizer.state == .began || pinchRecognizer.state == .changed {
            pinchRecognizer.view?.transform = (pinchRecognizer.view?.transform.scaledBy(x: pinchRecognizer.scale, y: pinchRecognizer.scale))!
           pinchRecognizer.scale = 1.0
        }
        
    }
}
    

