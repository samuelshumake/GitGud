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
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var repoEntry: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var gitImage: UIImageView!
    
    var dataSession = RepoData()
//    var repoInfo: Dictionary<String, Array<Commit>> = [:]
    var repoInfo: [String: [Commit]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
    }

    @IBAction func repoDataFunc(_ sender: Any) {
        let entry: String = usernameEntry.text! + "/" + repoEntry.text!
//        self.dataSession.getRepoData(userInfo: entry)
        self.dataSession.getRepoData(userInfo: "samuelshumake/GitGud")
    }
    
    func nextScreen(_ sender: Any) {
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "GitDetail", sender: self)
        }
    }
    
    
    // MARK: Reponse Handlers
    func repoResponse(data: Dictionary<String, Array<Commit>>) {
        repoInfo = data
        print(repoInfo)
        nextScreen(self)
        DispatchQueue.main.async() {
            self.errorLabel.text = ""
            self.gitImage.image = UIImage(named: "Git")
        }
    }
    
    func responseError(message: String) {
        DispatchQueue.main.async() {
            self.errorLabel.text = message
            self.gitImage.image = UIImage(named: "GitError")
        }
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GitDetail" {
            let contentViewController = segue.destination as? GitVisualizerViewController
            contentViewController!.repoInfo = self.repoInfo
        }
    }
    
}

