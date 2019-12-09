//
//  RepoData.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

protocol RepoDataProtocol {
    func repoResponse(data: [Commit])
    func responseError(message: String)
}

struct Commit {
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
    var RepoCommits: [Commit] = []
    
    init() {}
    
    func getCommits(userInfo: String) {
        var urlPath = self.urlPathBase
        urlPath += userInfo
        let url:NSURL? = NSURL(string: urlPath)
        let repoTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                self.delegate?.responseError(message: "Unable to connect.")
            } else {
                do {
                    if data != nil {
                        let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        let commits = jsonResult as? NSArray
                        if commits != nil {
                            for i in commits! {
                                let commit = i as? NSDictionary
                                let commitInfo = commit!["commit"]! as? NSDictionary
                                
                                // Gets sha of commit
                                let sha = commit!["sha"]! as? String
                                
                                // Gets info of commit author
                                let author = commitInfo!["author"]! as? NSDictionary
                                let name = author!["name"]! as? String
                                let email = author!["email"]! as? String
                                var date = author!["date"]! as? String
                                
                                date = date?.replacingOccurrences(of: "[^0-9:]", with: ".", options: [.regularExpression])
                                
                                let dateArray = date!.split(separator: ".")
                                
                                date = "\(dateArray[1])/\(dateArray[2])/\(dateArray[0]) -- \(dateArray[3])"
        
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
                                }
                                
                                // Create commit struct and append to RepoCommits
                                let commitStruct = Commit(message: message!, date: date!, author: name!, email: email!, sha: sha!, pSha: pSha)
                                self.RepoCommits.insert(commitStruct, at: 0)
                            }
                            self.delegate?.repoResponse(data: self.RepoCommits)
                        } else {
                            self.delegate?.responseError(message: "Invalid entry.")
                        }
                        
                    }
                } catch {

                }
            }
        }
        repoTask.resume()
    }
}

