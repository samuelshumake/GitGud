//
//  RepoData.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

protocol BranchDataProtocol {
    func responseDataHandler(data: NSDictionary)
    func responseError(message: String)
}

struct Commit {
    var message: String
    var date: String
    var author: String
    var email: String
    var sha: String
    
}

class BranchData {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://api.github.com/repos/samuelshumake/GitGud/commits?sha=dev"
    private var dataTask: URLSessionDataTask? = nil
    var delegate: BranchDataProtocol? = nil

    init() {}
    
    var BranchCommits: Array<Commit> = []
    
    func getBranchData() {
        let urlPath = self.urlPathBase
        let url:NSURL? = NSURL(string: urlPath)
        
        
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    let data = NSData(contentsOf: URL(string: self.urlPathBase)!)
                    if data != nil {
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let branch = jsonResult as? [Dictionary<String, Any>]
                        for i in branch! {
                            let commit = i["commit"] as? NSDictionary
                            let commitAuthorDict = commit!["author"]! as? NSDictionary
                            let commitMessage = commit!["message"]! as? String
                            let commitDate = commitAuthorDict!["date"]! as? String
                            let commitAuthor = commitAuthorDict!["name"]! as? String
                            let commitEmail = commitAuthorDict!["email"]! as? String
                            let commitSHA = i["sha"] as? String
                            
                            let commitStruct = Commit(message: commitMessage!, date: commitDate!, author: commitAuthor!, email: commitEmail!, sha: commitSHA!)
                            self.BranchCommits.append(commitStruct)
                        }
                    }
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        dataTask.resume()
    }
}
