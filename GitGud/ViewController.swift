//
//  ViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RepoDataProtocol {
    
    @IBOutlet weak var testButton: UIButton!
    
    var dataSession = RepoData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func testRepo(_ sender: Any) {
        self.dataSession.getRepoData()
    }
    
    
    // MARK: Reponse Handlers
    func responseDataHandler(data: NSDictionary) {
    }
    
    func responseError(message: String) {
        DispatchQueue.main.async() {
        }
    }
    
}

