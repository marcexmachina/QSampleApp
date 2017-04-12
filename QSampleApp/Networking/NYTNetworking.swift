//
//  NYTNetworking.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 05/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

let apiKey = "1d224d4ed8ab4464b46c3e88b768ce66"
let topStoriesApiBaseUrl = "https://api.nytimes.com/svc/topstories/v2/"
let articleSearchApiBaseUrl = "https://api.nytimes.com/svc/search/v2/articlesearch"
let formatString: String = ".json"

class NYTNetworking {
    
    static let nyts = NYTNetworking()
    
    var titles: [String]?
    
    // Get titles from Section response
    func getSectionTitles(section: String, completionHandler: @escaping (Any?, Error?) -> ()) {
        
        let endpoint = topStoriesApiBaseUrl + section + formatString
        let params: Parameters = ["api-key": apiKey]
        
        AFUtils.afs.makeGetRequest(url: endpoint, parameters: params) {
            (response, error) in
            
            if let response = response {
                let json = JSON(response)
                let results = json["results"].arrayValue
                var titles = [String]()
                for element in results {
                    let title = element["title"].stringValue
                    titles.append(title)
                }
                completionHandler(titles, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    func getTopStoriesForSection(section: String, completionHandler: @escaping (Any?, Error?) -> ()) {
        
        let endpoint = topStoriesApiBaseUrl + section + formatString
        let params: Parameters = ["api-key": apiKey]
        
        AFUtils.afs.makeGetRequest(url: endpoint, parameters: params) {
            (response, error) in
            
            if let response = response {
                let json = JSON(response)
                let results = json["results"]
                completionHandler(results, nil)
            } else {
                completionHandler(nil, error)
            }
        }

    }
    
    func getArticleForHeadline(headline: String, completionHandler: @escaping (Any?, Error?) -> ()) {
        
        let endpoint = articleSearchApiBaseUrl + formatString
        var params: Parameters = [String: String]()
        params["api-key"] = apiKey
        params["q"] = headline
        
        AFUtils.afs.makeGetRequest(url: endpoint, parameters: params) {
            (response, error) in
            
            if let response = response {
                let json = JSON(response)
                let docs = json["response"]["docs"].arrayValue
                var leadParagraph: String = ""
                for element in docs {
                    leadParagraph = element["lead_paragraph"].stringValue
                }
                completionHandler(leadParagraph, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    func getThumbnailForHeadline(imagePath: String, completionHandler: @escaping (UIImage?) -> ()) {
        Alamofire.request(imagePath, method: .get, parameters: [:], encoding: URLEncoding.default)
            .validate { request, response, imageData in
                if let downloadedImage = UIImage(data: imageData!) {
                    completionHandler(downloadedImage)
                } else {
                }
                return .success
        }
    }
    
    
    
    
    
    
}
