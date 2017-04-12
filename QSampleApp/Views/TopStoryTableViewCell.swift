//
//  TopStoryTableViewCell.swift
//  QSampleApp
//
//  Created by Marc O'Neill on 12/04/2017.
//  Copyright © 2017 marcexmachina. All rights reserved.
//

import UIKit

class TopStoryTableViewCell: UITableViewCell {

  @IBOutlet var thumbnailImageView: UIImageView!
  @IBOutlet var headlineTitleLabel: UILabel!
  @IBOutlet var publishedDateLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
