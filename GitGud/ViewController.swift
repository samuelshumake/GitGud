//
//  ViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RepoDataProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var repoEntry: UITextField!
    @IBOutlet weak var branchEntry: UITextField!
    @IBOutlet weak var test2Button: UIButton!
    var dataSession = RepoData()
    var repoListCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
        self.repoTableView.delegate = self
        self.repoTableView.dataSource = self
    }

    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        let userEntry: String = usernameEntry.text!
        self.dataSession.getRepos(username: userEntry)
        usernameEntry.resignFirstResponder()
    }

    // private let urlPathBase = "https://api.github.com/repos/samuelshumake/GitGud/commits?sha=dev"
    @IBAction func testRepo(_ sender: Any) {
        let entry: String = usernameEntry.text! + "/" + repoEntry.text! + "/commits?sha=" + branchEntry.text!
        self.dataSession.getRepoData(userInfo: entry)
    }
    
    @IBAction func test2User(_ sender: Any) {
        self.dataSession.getRepos(username: usernameEntry.text!)
    }
    
    func repoResponse(data: Array<String>) {
        repoListCount = data.count
    }
    
    // MARK: Reponse Handlers
    func commitResponse(data: Array<Commit>) {
        print(data)
    }
    
    func responseError(message: String) {
        DispatchQueue.main.async() {
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) 
        cell.textLabel?.text = "test"
        return cell
    }
    
}

