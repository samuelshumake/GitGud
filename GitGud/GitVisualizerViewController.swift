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
    @IBOutlet weak var gitScroll: UIScrollView!
    var repoInfo: Dictionary<String, Array<Commit>> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        gitDraw.repoInfo = repoInfo
        gitDraw.frame = CGRect(x: 0, y: 0, width: gitDraw.frame.width, height: 4000)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewWidth = gitDraw.frame.width
        let viewHeight = gitDraw.frame.height
        gitScroll.contentSize = CGSize(width: viewWidth, height: viewHeight)
    }
    
    @IBAction func pinchZoom(_ sender: UIPinchGestureRecognizer) {
        if pinchRecognizer.state == .began || pinchRecognizer.state == .changed {
            pinchRecognizer.view?.transform = (pinchRecognizer.view?.transform.scaledBy(x: pinchRecognizer.scale, y: pinchRecognizer.scale))!
           pinchRecognizer.scale = 1.0
        }
        
    }
}
    

