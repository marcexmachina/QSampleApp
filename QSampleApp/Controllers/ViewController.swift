//
//  ViewController.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 04/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CategoryFetcherDelegate {
    
    let tableView: UITableView = UITableView()
    let categoryPicker: UIPickerView = UIPickerView()
    var categoryTitles: [String] = [String]()
    var categoryTopStories: [Headline] = [Headline]()
    
    var categoryController: CategoryPickerController = CategoryPickerController()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopStoryTableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.register(UINib(nibName: "TopStoryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        categoryPicker.dataSource = categoryController
        categoryPicker.delegate = categoryController
       
        categoryController.categoryFetcherDelegate = self
        
        self.view.addSubview(tableView)
        self.view.addSubview(categoryPicker)
        
        updateTableViewConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryTopStories.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopStoryTableViewCell
        let headline = categoryTopStories[indexPath.section]
        cell.headlineTitleLabel.text = headline.title
        cell.publishedDateLabel.text = headline.formattedPublishedDateString()
        
        if let thumbnail = headline.thumbnail {
            cell.thumbnailImageView.image = thumbnail
        } else {
            if let thumbnailUrl = headline.imageUrls["Standard Thumbnail"] {
                NYTNetworking.nyts.getThumbnailForHeadline(imagePath: thumbnailUrl) {
                    image in
                    DispatchQueue.main.async {
                        cell.thumbnailImageView.image = image
                    }
                }
            }
        }
      return cell
  }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 125
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    // MARK: - Constraints
    func updateTableViewConstraints() {
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = ["tableView": self.tableView,
                     "categoryPicker": self.categoryPicker,
                     "topLayoutGuide": topLayoutGuide,
                     "bottomLayoutGuide": bottomLayoutGuide
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let tableViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[topLayoutGuide]-[categoryPicker]-[tableView]|",
                                                                          options: [.alignAllLeading, .alignAllTrailing],
                                                                          metrics: nil,
                                                                          views: views)
        allConstraints += tableViewVerticalConstraints
        
        let tableViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|",
                                                                            options: [],
                                                                            metrics: nil,
                                                                            views: views)
        allConstraints += tableViewHorizontalConstraints
        
        self.view.addConstraints(allConstraints)
    }
    
    func updateHeadlines(headlines: [Headline]) {
        self.categoryTopStories = headlines
        self.tableView.reloadData()
    }

}

