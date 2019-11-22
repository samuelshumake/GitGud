//
//  RepoData.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

protocol RepoDataProtocol {
    func repoResponse(data: Array<LinkedList<Node<Commit>>>)
    func responseError(message: String)
}

struct Commit {
    var repo: String
    var message: String
    var date: String
    var author: String
    var email: String
    var sha: String
}

class RepoData {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://api.github.com/repos/"
    private var dataTask: URLSessionDataTask? = nil
    var delegate: RepoDataProtocol? = nil

    init() {}
    
    var RepoCommits: Array<LinkedList<Node<Commit>>> = []
    
    func getRepoData(userInfo: String) {
//        let userInfo = userInfo.trimmingCharacters(in: .whitespacesAndNewlines)
//        var urlPath = self.urlPathBase
//        urlPath = urlPath + userInfo + "/branches"
        let urlPath = "https://api.github.com/repos/samuelshumake/GitGud/branches"
        let url:NSURL? = NSURL(string: urlPath)
        let repoTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if data != nil {
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let branches = jsonResult as? [Dictionary<String, Any>]
                        for i in branches! {
                            let repo = i["name"]! as? String
                            let dict = i["commit"]! as? NSDictionary
                            let sha = dict!["sha"] as? String
                            self.getCommits(userInfo: userInfo, sha: sha!, repo: repo!)

                        }
                    }
                    self.delegate?.repoResponse(data: self.RepoCommits)
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        repoTask.resume()
    }
    
    func getCommits(userInfo: String, sha: String, repo: String) {
        var urlPath = self.urlPathBase
        urlPath = urlPath + userInfo + "/commits/" + sha
        let url:NSURL? = NSURL(string: urlPath)
        let repoTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    if data != nil {
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let commit = jsonResult as? NSDictionary
                        // TODO: Get relevant info from commits and push to RepoCommits linked list as Commit structs
                    }
                } catch {
                    
                }
            }
        }
        repoTask.resume()
    }
    
//    func getRepos(username: String) {
//        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
//        var urlPath = self.urlPathBase + "users/" + username + "/repos"
//        urlPath = self.urlPathBase + "users/samuelshumake/repos"         //TESTING
//        let url: NSURL? = NSURL(string: urlPath)
//
//        let userTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
//            if error != nil {
//                print(error!)
//            } else {
//                do {
//                    if data != nil {
//                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                        let user = jsonResult as? [Dictionary<String, Any>]
//                        for i in user! {
//                            let repo = i["name"]! as? String
//                            self.Repos.append(repo!)
////                            let branch = "repos/samuelshumake/" + repo! + "/branches"
////                            let created = i["created_at"]! as? String
////                            let updated = i["pushed_at"]! as? String
//                        }
//                    }
//                    self.delegate?.repoResponse(data: self.Repos)
//                } catch {
//
//                }
//            }
//        }
//        userTask.resume()
//
//    }

}
