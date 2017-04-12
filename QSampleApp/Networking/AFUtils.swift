//
//  AFUtils.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 05/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import Alamofire

class AFUtils {
    
    static let afs = AFUtils()
    
    func makeGetRequest(url: String, parameters: [String: Any], completionHandler: @escaping (Any?, Error?) -> ()) {
        Alamofire.request(url, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    
}
