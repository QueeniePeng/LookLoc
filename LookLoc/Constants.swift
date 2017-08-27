//
//  Constants.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation


struct Constants {

    static let ApiKey: String = "AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0"
    static let Status: String = "status"
    
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
        static var Input: String = "" // get from user
        static let OffSet: String = "3"
        static let Radius: String = "50000"
        static let Location: String = "41.8781,-87.6298" // chicago lat,lon
    }
    
    struct AutocompleteResponseKeys {
        static let Predictions: String = "predictions"
        static let Description: String = "description"
        static let Name: String = "main_text"
        static let Vincinity: String = "secondary_text"
        static let StructuredFormat: String = "structured_formatting"
    }
    
    // Location
    struct LocationSearchKeys {
        static let ApiKey: String = "key"
        static let Radius: String = "radius"
        static let Query: String = "query"
        static let Location: String = "location"
        static let Language: String = "language"
    }
    
    struct LocationSearchValues {
        static var Query: String = "" // get from user
        static let Radius: String = "50000"
        static let Language: String = "en"
        static let Location: String = "41.8781,-87.6298" // chicago lat,lon
    }
    
    struct LocationResponseKeys {
        static let Results: String = "results"
        static let Icon: String = "icon"
        static let Name: String = "name"
        static let Types: String = "types"
        static let Rating: String = "rating"
        static let Formatted_Address: String = "formatted_address"
        
        static let OpenHour: String = "opening_hours" // nest in open now
        static let OpenNow: String = "open_now"
        
        static let Photos: String = "Photos" // nest in html
        static let Html: String = "html_attributions"
    }
}
