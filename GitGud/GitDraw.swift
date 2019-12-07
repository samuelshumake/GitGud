//
//  GitDraw.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/11/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

@IBDesignable
class GitDraw: UIView {
    
    @IBInspectable
    var circleColor: UIColor = UIColor.blue
    var outlineColor: UIColor = UIColor.black
    
    var repoInfo: [String: [Commit]] = [:]
    
    override func draw(_ rect: CGRect) {
        let x = bounds.width / 2
        var y = bounds.height - 40
        
        for branch in repoInfo {
            for commit in branch.value {
                let p = CGPoint(x: x, y: y)
                drawCommit(center: p)
                y -= 100
                // CYCLES THROUGH THE COMMITS
            }
        }
    }
    
    func drawCommit(center: CGPoint) {
        let radius: CGFloat = 20.0
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * .pi
        let path = UIBezierPath(arcCenter: center,
                                   radius: radius,
                                   startAngle: startAngle,
                               endAngle: endAngle,
                                clockwise: true)
        outlineColor.setFill()
        path.fill()
    }
}
