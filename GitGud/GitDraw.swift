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
    var storedCommits: Array<String> = []
    var repoArray: [Dictionary<String, Array<Commit>>] = []
    
    
    override func draw(_ rect: CGRect) {
//        print(repoInfo["dev"]!.last!.date)
        
//        for i in repoInfo {
//            var itemCount = i.value.count
//            if repoArray.isEmpty {
//                print(i.value)
//            } else {
////                for j in repoArray {
////                    print(j)
////                }
//            }
//            
//        }
        
        
        
        
        
        
        var x = bounds.width / 2
        var y = bounds.height - 200
        for branch in repoInfo {
            for commit in branch.value {
//                print("\(branch.key): \(storedCommits.contains(commit.sha))  - \(commit.message)")
                if storedCommits.contains(commit.sha) {
//                    print("don't draw")
                } else {
//                    print("draw something")
                    let p = CGPoint(x: x, y: y)
                    let btn = PushButton(frame: CGRect(x: x - 25, y: y, width: 50, height: 50))
                    self.addSubview(btn)
                }
                storedCommits.append(commit.sha)
                
                
                y -= 100
            }
//            print(branch.key)
            y = bounds.height - 200
            x += 100
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

