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
    
    @IBInspectable var startColor: UIColor = .blue
    @IBInspectable var endColor: UIColor = .blue
    
    var repoInfo: Dictionary<String, Array<Commit>> = [:]
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                       colors: colors as CFArray,
                                    locations: colorLocations)!
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                            start: startPoint,
                              end: endPoint,
                          options: [])
        
        var x = bounds.width / 2
        var y = bounds.height - 60
        
        for branch in repoInfo {
//            let p = CGPoint(x: x, y: y)
//            drawCommit(center: p)
            
            // DRAWING THE 3 BRANCHES
            print("\n\n")
            for commit in branch.value {
                
                let p = CGPoint(x: x, y: y)
                drawCommit(center: p)
                y -= 100
                print(y)
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
