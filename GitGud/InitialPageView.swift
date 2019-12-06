//
//  InitialPageView.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/6/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

@IBDesignable
class InitialPageView: UIView {

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
    }

}

@IBDesignable
class EntryButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.green
    
//    override func draw(_ rect: CGRect) {
//    }
}
