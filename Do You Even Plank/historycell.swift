//
//  historycell.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/19/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit

class historycell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
