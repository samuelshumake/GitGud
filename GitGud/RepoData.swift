//
//  RepoData.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

protocol RepoDataProtocol {
    func repoResponse(data: Dictionary<String, Array<Commit>>)
    func responseError(message: String)
}

struct Commit {
    var repo: String
    var message: String
    var date: String
    var author: String
    var email: String
    var sha: String
    var pSha: String
}

class RepoData {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://api.github.com/repos/"
    private var dataTask: URLSessionDataTask? = nil
    var delegate: RepoDataProtocol? = nil
    var RepoCommits: [String: [Commit]] = [:]

    init() {}
    
    func getRepoData(userInfo: String) {
        let userInfo = userInfo.trimmingCharacters(in: .whitespacesAndNewlines)
        var urlPath = self.urlPathBase
        urlPath = urlPath + userInfo + "/branches"
        let url:NSURL? = NSURL(string: urlPath)
        let repoTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if data != nil {
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let branches = jsonResult as? [Dictionary<String, Any>]
                        if branches != nil {
                            for (i, element) in branches!.enumerated() {
                                let repo = element["name"]! as? String
                                self.RepoCommits[repo!] = []
                                if (i == branches!.count - 1) {
                                    self.getCommits(userInfo: userInfo, repo: repo!, end: true)
                                } else {
                                    self.getCommits(userInfo: userInfo, repo: repo!, end: false)
                                }

                            }
                        } else {
                            self.delegate?.responseError(message: "Invalid username or repository.")
                        }
                    }
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        repoTask.resume()
    }
    func getCommits(userInfo: String, repo: String, end: Bool) {
        var urlPath = self.urlPathBase
        urlPath = urlPath + userInfo + "/commits?sha=" + repo
        let url:NSURL? = NSURL(string: urlPath)
        let repoTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if data != nil {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let commits = jsonResult as? NSArray
                        for i in commits! {
                            let commit = i as? NSDictionary
                            let commitInfo = commit!["commit"]! as? NSDictionary
                            
                            // Gets sha of commit
                            let sha = commit!["sha"]! as? String
    
                            // Gets info of commit author
                            let author = commitInfo!["author"]! as? NSDictionary
                            let name = author!["name"]! as? String
                            let email = author!["email"]! as? String
                            let date = author!["date"]! as? String
    
                            // Gets commit message
                            let message = commitInfo!["message"]! as? String
    
                            // Gets parent commits
                            var pSha: String
                            let parents = commit!["parents"]! as? NSArray
                            if (parents!.count != 0) {
                                let parentDict = parents![0] as? NSDictionary
                                pSha = (parentDict!["sha"]! as? String)!
                            } else {
                                pSha = "done"
                            }               // TODO: Allow for multiple parents, AKA merges
                            
                            // Create commit struct and append to RepoCommits
                            let commitStruct = Commit(repo: repo, message: message!, date: date!, author: name!, email: email!, sha: sha!, pSha: pSha)
                            self.RepoCommits[repo]!.append(commitStruct)
                        }
                        if (end) {
                            self.delegate?.repoResponse(data: self.RepoCommits)
                        }
                    }
                } catch {

                }
            }
        }
        repoTask.resume()
    }
}

