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
    @IBOutlet weak var LBTypeOne: UILabel!
    
    @IBOutlet weak var RatingView: UIView! // TODO: change color based on the rating
    @IBOutlet weak var TypeView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

        let blueColor = RatingView.backgroundColor

        if selected == true {
            RatingView.backgroundColor = UIColor.darkGray
            TypeView.backgroundColor = UIColor.darkGray

        } else {
            RatingView.backgroundColor = blueColor
            TypeView.backgroundColor = blueColor
        }
    }
}
