//
//  LocationDetailCell.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/27.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class LocationDetailCell: UITableViewCell {

    @IBOutlet weak var IVIcon: UIImageView!
    @IBOutlet weak var LBName: UILabel!
    @IBOutlet weak var LBAddress: UILabel!
    @IBOutlet weak var LBRating: UILabel!
    @IBOutlet weak var LBOpenNow: UILabel!
    
    // types
    @IBOutlet weak var LBTypeOne: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
