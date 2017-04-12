//
//  Headline.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 05/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import UIKit

class Headline {
    
    var title: String
    var imageUrls: [String: String]
    var publishedDate: Date
    var thumbnail: UIImage?
    
    init(title: String, imageUrls: [String: String], publishedDate: Date) {
        self.title = title
        self.imageUrls = imageUrls
        self.publishedDate = publishedDate
    }
    
}
