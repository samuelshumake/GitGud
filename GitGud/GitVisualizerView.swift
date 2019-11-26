//
//  GitVisualizerView.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/11/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

@IBDesignable
class GitVisualizerView: UIView {

    @IBInspectable
    var circleColor: UIColor = UIColor.blue
    var outlineColor: UIColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: 300, y: 30)
        drawCommit(center: center)
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
        path.lineWidth = 2.0
        circleColor.setFill()
        outlineColor.setStroke()
        path.fill()
        path.stroke()
    }

}
