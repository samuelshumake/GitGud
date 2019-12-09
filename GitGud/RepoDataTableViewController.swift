//
//  RepoDataTableViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/7/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class RepoDataTableViewController: UITableViewController {
    
    var repoInfo: [Commit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CommitCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomRepoTableViewCell
        
        cell.messageLabel.text = self.repoInfo[indexPath.row].message
        cell.commitNumber.text = "C\(indexPath[1] + 1)"

        return cell
    }

    // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination
         // Pass the selected object to the new view controller.
         
        if segue.identifier == "CellDetail" {
             
            let contentViewController = segue.destination as? CommitCellViewController

            if let selectedCell = sender as? CustomRepoTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let message = self.repoInfo[indexPath.row].message
                let num = "C\(indexPath.row + 1)"
                let date = self.repoInfo[indexPath.row].date
                let author = self.repoInfo[indexPath.row].author
                let email = self.repoInfo[indexPath.row].email
                let sha = self.repoInfo[indexPath.row].sha
                let pSha = self.repoInfo[indexPath.row].pSha
                
                if (contentViewController != nil) {
                    contentViewController!.commitMessageText = message
                    contentViewController!.commitNumText = num
                    contentViewController!.commitDateText = date
                    contentViewController!.commitAuthorText = author
                    contentViewController!.commitAuthorEmailText = email
                    contentViewController!.commitShaText = sha
                    contentViewController!.commitPShaText = pSha
                    
                }
            }
        }
    }


}

