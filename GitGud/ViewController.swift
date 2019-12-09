//
//  ViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, RepoDataProtocol {

    @IBOutlet weak var getData: UIButton!
    @IBOutlet weak var usernameEntry: UITextField!
    @IBOutlet weak var repoEntry: UITextField!
    @IBOutlet weak var branchEntry: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var gitImage: UIImageView!
    
    var dataSession = RepoData()
    var repoInfo: [Commit] = []
    var user: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "User")
        
      
      //3
      do {
        user = try managedContext.fetch(fetchRequest)
        if !user.isEmpty {
            self.usernameEntry.text = user[0].value(forKeyPath: "name") as? String
            self.repoEntry.text = user[0].value(forKeyPath: "repo") as? String
            self.branchEntry.text = user[0].value(forKeyPath: "branch") as? String
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }


    @IBAction func repoDataFunc(_ sender: Any) {
        let entry: String = usernameEntry.text! + "/" + repoEntry.text! + "/commits?sha=" + branchEntry.text!
        
        // Deletes previous user entry and saves new one so the app will always
        // remember the last login info
        self.deleteAllRecords()
        self.save(name: self.usernameEntry.text!, repo: self.repoEntry.text!, branch: self.branchEntry.text!)
        self.dataSession.getCommits(userInfo: entry)
    }
    
    func nextScreen(_ sender: Any) {
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "GitDetail", sender: self)
        }
    }
    
    // MARK: Reponse Handlers
    func repoResponse(data: [Commit]) {
        repoInfo = data
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
            let contentViewController = segue.destination as? RepoDataTableViewController
            contentViewController!.repoInfo = self.repoInfo
        }
    }
    
    // MARK: Core Data Saving and Deleting
    func save(name: String, repo: String, branch: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        // 1
        let managedContext = appDelegate.persistentContainer.viewContext

        // 2
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!

        let User = NSManagedObject(entity: entity, insertInto: managedContext)

        // 3
        User.setValue(name, forKeyPath: "name")
        User.setValue(repo, forKeyPath: "repo")
        User.setValue(branch, forKeyPath: "branch")


        // 4
        do {
            try managedContext.save()
            user.append(User)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllRecords() {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
