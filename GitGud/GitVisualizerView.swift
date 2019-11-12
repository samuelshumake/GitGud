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
    
    private struct Constants {
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
    
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }

    @IBInspectable
    var circleColor: UIColor = UIColor.blue
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)

        // 3
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * .pi
        
        let path = UIBezierPath(arcCenter: center,
                                   radius: radius/10 - Constants.arcWidth/2,
                                   startAngle: startAngle,
                               endAngle: endAngle,
                                clockwise: true)

        // 5
        path.lineWidth = Constants.arcWidth
        circleColor.setStroke()
        path.stroke()
    }

}
