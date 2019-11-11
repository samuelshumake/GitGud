//
//  ViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BranchDataProtocol {
    
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var repoEntry: UITextField!
    @IBOutlet weak var branchEntry: UITextField!
    
    var dataSession = BranchData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
        // Do any additional setup after loading the view.
    }

    // private let urlPathBase = "https://api.github.com/repos/samuelshumake/GitGud/commits?sha=dev"
    @IBAction func testRepo(_ sender: Any) {
        let entry: String = usernameEntry.text! + "/" + repoEntry.text! + "/commits?sha=" + branchEntry.text!
        self.dataSession.getBranchData(userInfo: entry)
    }
    
    
    // MARK: Reponse Handlers
    func responseDataHandler(data: Array<Commit>) {
        print(data)
    }
    
    func responseError(message: String) {
        DispatchQueue.main.async() {
        }
    }
    
}

