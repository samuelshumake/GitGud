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
    private let urlPathBase = "https://api.github.com/repos/samuelshumake/GitGud/git/trees/"
    private var dataTask: URLSessionDataTask? = nil
    var delegate: RepoDataProtocol? = nil

    init() {}
    
    func getRepoData() {
        let urlPath = self.urlPathBase
        let url:NSURL? = NSURL(string: urlPath)
        
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    print(jsonResult)
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        dataTask.resume()
    }
}
