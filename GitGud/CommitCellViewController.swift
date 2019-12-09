//
//  CommitCellViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/7/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class CommitCellViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var commitNum: UILabel!
    @IBOutlet weak var commitMessage: UILabel!
    @IBOutlet weak var commitDate: UILabel!
    @IBOutlet weak var commitAuthor: UILabel!
    @IBOutlet weak var commitAuthorEmail: UILabel!
    @IBOutlet weak var commitSha: UILabel!
    @IBOutlet weak var commitPSha: UILabel!
    
    var commitNumText: String = String()
    var commitMessageText: String = String()
    var commitDateText: String = String()
    var commitAuthorText: String = String()
    var commitAuthorEmailText: String = String()
    var commitShaText: String = String()
    var commitPShaText: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitNum.text = self.commitNumText
        commitMessage.text = self.commitMessageText
        commitDate.text = self.commitDateText
        commitAuthor.text = self.commitAuthorText
        commitAuthorEmail.text = self.commitAuthorEmailText
        commitSha.text = self.commitShaText
        commitPSha.text = self.commitPShaText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

@IBDesignable
class CellView: UIView {

    @IBInspectable var startColor: UIColor = .blue
    @IBInspectable var endColor: UIColor = .blue
    var lineColor: UIColor = .white
    
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
