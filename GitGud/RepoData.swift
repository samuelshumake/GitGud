//
//  RepoData.swift
//  GitGud
//
//  Created by Samuel Shumake on 11/8/19.
//  Copyright © 2019 Samuel Shumake. All rights reserved.
//

import UIKit

protocol RepoDataProtocol {
    func responseDataHandler(data: NSDictionary)
    func responseError(message: String)
}

class RepoData{
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://api.github.com/repos/samuelshumake/GitGud/commits?sha=dev"
    private var dataTask: URLSessionDataTask? = nil
    var delegate: RepoDataProtocol? = nil

    init() {}
    
    var gitSHA: Array<String> = []
    
    func getRepoData() {
        let urlPath = self.urlPathBase
        let url:NSURL? = NSURL(string: urlPath)
        
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    let data = NSData(contentsOf: URL(string: self.urlPathBase)!)
                    let jsonResult = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let branch = jsonResult as? [Dictionary<String, Any>]
                    for i in branch! {
                        let commit = i["commit"] as? NSDictionary
                        let commitMessage = commit!["message"]!
                        let commitAuthorDict = commit!["author"]! as? NSDictionary
                        let commitSHA = i["sha"]
                    }
                    
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        dataTask.resume()
    }
}
