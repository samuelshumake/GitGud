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
    
    @IBInspectable var fillColor: UIColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(22))
        fillColor.setFill()
        path.fill()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer

        
    }
}
