//
//  ModalBranchTableViewController.swift
//  GitGud
//
//  Created by Samuel Shumake on 12/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

class ModalBranchTableViewController: UITableViewController {

    var repoInfo: [String: [Commit]] = [:]
    var repoOverview: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in repoInfo {
            let name = i.key
            print(i.value)
            let author = i.value.first!.author
            var updated = i.value.first!.date
            updated = updated.replacingOccurrences(of: "[^0-9:]", with: ".", options: [.regularExpression])
            let updatedArray = updated.split(separator: ".")
            updated = "\(updatedArray[2])/\(updatedArray[1])/\(updatedArray[0]) \(updatedArray[3])"
            repoOverview.append([name, author, updated])
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repoOverview.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RepoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomRepoTableViewCell
        
        let ind = indexPath[1]
                
        cell.repoName.text = repoOverview[ind][0]
        cell.authorName.text = repoOverview[ind][1]
        cell.updatedLast.text = repoOverview[ind][2]
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
