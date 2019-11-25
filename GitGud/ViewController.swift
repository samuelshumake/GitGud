//
//  ViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RepoDataProtocol {

    @IBOutlet weak var getData: UIButton!
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var repoEntry: UITextField!
    var dataSession = RepoData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
    }

    @IBAction func repoDataFunc(_ sender: Any) {
        let entry: String = usernameEntry.text! + "/" + repoEntry.text!
        self.dataSession.getRepoData(userInfo: entry)
    }
    
    // MARK: Reponse Handlers
    func repoResponse(data: Array<Commit>) {
        print(data)
    }
    
    func responseError(message: String) {
        DispatchQueue.main.async() {
        }
    }
    
}

