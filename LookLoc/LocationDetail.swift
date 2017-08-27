//
//  LocationDetail.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/27.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class LocationDetail {
    let icon: String
    let name: String
    let rating: Float
    let types: [String]
    let address: String
    let openNow: Bool
    
    init(icon: String, name: String, rating: Float, types: [String], address: String, openNow: Bool) {
        self.icon = icon
        self.name = name
        self.rating = rating
        self.types = types
        self.address = address
        self.openNow = openNow
    }
}
