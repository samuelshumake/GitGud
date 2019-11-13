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
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var repoEntry: UITextField!
    @IBOutlet weak var branchEntry: UITextField!
    @IBOutlet weak var test2Button: UIButton!
    var dataSession = RepoData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
    }

    // private let urlPathBase = "https://api.github.com/repos/samuelshumake/GitGud/commits?sha=dev"
    @IBAction func testRepo(_ sender: Any) {
        let entry: String = usernameEntry.text! + "/" + repoEntry.text! + "/commits?sha=" + branchEntry.text!
        self.dataSession.getRepoData(userInfo: entry)
        
        // TODO: When user types in their username, the app will automatically pull up a dropdown list of their accessible repositories and branches
    }
    @IBAction func test2User(_ sender: Any) {
        self.dataSession.getRepos(username: "lol")
    }
    
    func repoResponse(data: Array<String>) {
        print(data)
    }
    // MARK: Reponse Handlers
    func commitResponse(data: Array<Commit>) {
        print(data)
    }
    
    func responseError(message: String) {
        DispatchQueue.main.async() {
        }
    }
    
}

