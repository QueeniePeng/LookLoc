//
//  Constants.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation


struct Constants {
    
    // restaurant example
    // https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0&location=41.8781,-87.6298&radius=50000&type=restaurant&keyword=volare
    
    // auto complete example
    // https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0&input=volare&offset=3location=41.8781,-87.6298&radius=50000

    
    static let ApiKey: String = "AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0"
    
    // auto complete
    struct AutocompleteSearchKeys {
        static let Input = "input"
        static let OffSet = "offset"
        static let Radius = "radius"
        static let Location = "location"
    }
    
    struct AutocompleteResponseKeys {
        static let Name: String = "main_text"
        static let Vincinity: String = "secondary_text"
        static let StructuredFormat: String = "structured_formatting"
    }
    
    // restaurant
    struct RestaurantSearchKeys {
        static let Radius: String = "radius"
        static let keyword: String = "keyword"
        static let Location: String = "location"
        static let Language: String = "language"
        static let BusinessType: String = "type"
    }
    
    struct RestaurantResponseKeys {
        static let Icon: String = "icon"
        static let Name: String = "name"
        static let Rating: String = "rating"
        static let Price: String = "price_level"
        static let Vincinity: String = "vicinity"
        
        static let OpenHour: String = "opening_hours" // nest in open now
        static let OpenNow: String = "open_now"
        
        static let Photos: String = "Photos" // nest in html
        static let Html: String = "html_attributions"
    }
}
