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
    // https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0&location=41.8781,-87.6298&radius=50000&type=restaurant&keyword=volare&language=en
    
    // auto complete example
    // https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0&input=volare&offset=3location=41.8781,-87.6298&radius=50000

    static let ApiKey: String = "AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0"
    
    // auto complete - keys
    struct AutocompleteSearchKeys {
        static let ApiKey: String = "key"
        static let Input: String = "input"
        static let OffSet: String = "offset"
        static let Radius: String = "radius"
        static let Location: String = "location"
    }
    
    // auto complete - values
    struct AutocompleteSearchValues {
        static let Input: String = "" // get from user
        static let OffSet: String = "3"
        static let Radius: String = "50000"
        static let Location: String = "41.8781,-87.6298" // chicago lat,lon
    }
    
    struct AutocompleteResponseKeys {
        static let Name: String = "main_text"
        static let Vincinity: String = "secondary_text"
        static let StructuredFormat: String = "structured_formatting"
    }
    
    // restaurant
    struct RestaurantSearchKeys {
        static let ApiKey: String = "key"
        static let Radius: String = "radius"
        static let keyword: String = "keyword"
        static let Location: String = "location"
        static let Language: String = "language"
        static let BusinessType: String = "types"
    }
    
    struct RestaurantSearchValues {
        static let Radius: String = "50000"
        static let keyword: String = "" // get from user
        static let Language: String = "en"
        static let BusinessType: String = "restaurant"
        static let Location: String = "41.8781,-87.6298" // chicago lat,lon
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
