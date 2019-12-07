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
    
    var repoInfo: [String: [Commit]] = [:]
    
    override func draw(_ rect: CGRect) {
        let x = bounds.width / 2
        var y = bounds.height - 200
        
        for branch in repoInfo {
            for commit in branch.value {
                let p = CGPoint(x: x, y: y)
                let btn = PushButton(frame: CGRect(x: x - 25, y: y, width: 50, height: 50))
                self.addSubview(btn)
                
                y -= 100
                // CYCLES THROUGH THE COMMITS
            }
        }
    }
}

class PushButton: UIButton {
//    var buttonColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    var fillColor: UIColor = UIColor.black
    

    override func draw(_ rect: CGRect) {
      let path = UIBezierPath(ovalIn: rect)
      fillColor.setFill()
      path.fill()
    }
}

