//
//  Headline+Extension.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 05/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

extension Headline {
    
    convenience init(json: [String: Any]) throws{
        guard let title = json["title"] as? String else {
            throw SerializationError.missing("title")
        }
        
        guard let multimedia = json["multimedia"] as? [[String: Any]] else {
            throw SerializationError.missing("multimedia")
        }

        guard let publishedDateString = json["published_date"] as? String else {
            throw SerializationError.missing("published_date")
        }
        
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let publishedDate: Date = dateFor.date(from: publishedDateString)!
        
        var urlDict = [String: String]()
        for element in multimedia {
            
            guard let format = element["format"] as? String,
                let url = element["url"] as? String else {
                    throw SerializationError.missing("images")
            }
            urlDict[format] = url
        }
        self.init(title: title, imageUrls: urlDict, publishedDate: publishedDate)
    }
    
    func formattedPublishedDateString() -> String {
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "MMM dd yyyy"
        return dateFor.string(from: publishedDate)
    }
    
}
