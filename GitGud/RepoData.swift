//
//  RepoData.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

protocol RepoDataProtocol {
    func repoResponse(data: Array<String>)
    func commitResponse(data: Array<Commit>)
    func responseError(message: String)
}

struct Commit {
    var message: String
    var date: String
    var author: String
    var email: String
    var sha: String
}

class RepoData {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://api.github.com/"
    private var dataTask: URLSessionDataTask? = nil
    var delegate: RepoDataProtocol? = nil

    init() {}
    
    
    var RepoCommits: Array<Commit> = []
    var Repos: Array<String> = []
    
    func getRepos(username: String) {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let urlPath = self.urlPathBase + "users/" + username + "/repos"
//        urlPath = urlPath + "users/samuelshumake/repos"               //TESTING
        let url: NSURL? = NSURL(string: urlPath)
        
        let userTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if data != nil {
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let user = jsonResult as? [Dictionary<String, Any>]
                        for i in user! {
                            let repo = i["name"]! as? String
                            self.Repos.append(repo!)
//                            let branch = "repos/samuelshumake/" + repo! + "/branches"
//                            let created = i["created_at"]! as? String
//                            let updated = i["pushed_at"]! as? String
                        }
                    }
                    self.delegate?.repoResponse(data: self.Repos)
                } catch {
                    
                }
            }
        }
        userTask.resume()
            
    }
    
    func getRepoData(userInfo: String) {
        let userInfo = userInfo.trimmingCharacters(in: .whitespacesAndNewlines)
        var urlPath = self.urlPathBase
        urlPath = urlPath + "repos/" + userInfo
        let url:NSURL? = NSURL(string: urlPath)
        
        let repoTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if data != nil {
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let repo = jsonResult as? [Dictionary<String, Any>]
                        for i in repo! {
                            let commit = i["commit"] as? NSDictionary
                            let commitAuthorDict = commit!["author"]! as? NSDictionary
                            let commitMessage = commit!["message"]! as? String
                            let commitDate = commitAuthorDict!["date"]! as? String
                            let commitAuthor = commitAuthorDict!["name"]! as? String
                            let commitEmail = commitAuthorDict!["email"]! as? String
                            let commitSHA = i["sha"] as? String
                            
                            let commitStruct = Commit(message: commitMessage!, date: commitDate!, author: commitAuthor!, email: commitEmail!, sha: commitSHA!)
                            self.RepoCommits.append(commitStruct)
                        }
                    }
                    self.delegate?.commitResponse(data: self.RepoCommits)
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        repoTask.resume()
    }
}
