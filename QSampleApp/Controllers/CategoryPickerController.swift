//
//  CategoryPickerController.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 05/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoryPickerController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var categoryFetcherDelegate: CategoryFetcherDelegate!
    
    let pickerData: [String] =
    ["Select a category",
    "home",
    "opinion",
    "world",
    "national",
    "politics",
    "upshot",
    "nyregion",
    "business",
    "technology",
    "science",
    "health",
    "sports",
    "arts",
    "books",
    "movies",
    "theater",
    "sundayreview",
    "fashion",
    "tmagazine",
    "food",
    "travel",
    "magazine",
    "realestate",
    "automobiles",
    "obituaries",
    "insider"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        NYTNetworking.nyts.getTopStoriesForSection(section: pickerData[row]) {
            (response, error) in
            
            if let results = response as? JSON {
                var topStories: [Headline] = [Headline]()
                for element in results.arrayValue {
                    if let element = element.dictionaryObject {
                        do {
                            let headline = try Headline(json: element)
                            topStories.append(headline)
                        } catch {
                            print(error)
                        }
                    }
                }
                self.categoryFetcherDelegate.updateHeadlines(headlines: topStories)
            }
            
        }
        
//        NYTNetworking.nyts.getSectionTitles(section: pickerData[row]) {
//            (response, error) in
//            
//            if let response = response as? [String]{
//                self.categoryFetcherDelegate.updateTitles(titles: response)
//            }
//        }
    }
}
