//
//  Constants.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation


struct Constants {

    static let ApiKey: String = "AIzaSyDCXiDCNA3avkE4fC2qhuLawk3VQhLy4hA"
    static let Status: String = "status"
    
    // TODO: status 
    enum StatusValue: String {
        case OK = "OK", ZERO = "ZERO_RESULTS", OVER = "OVER_QUERY_LIMIT"
    }
    static var StatusNow: String = ""
    // Auto complete - keys
    struct AutocompleteSearchKeys {
        static let ApiKey: String = "key"
        static let Input: String = "input"
        static let OffSet: String = "offset"
        static let Radius: String = "radius"
        static let Location: String = "location"
    }
    
    // Auto complete - values
    struct AutocompleteSearchValues {
        static var Input: String = "" // get from user
        static let OffSet: String = "3"
        static let Radius: String = "50000"
        static let Location: String = "41.8781,-87.6298" // chicago lat,lon
    }
    
    // Auto complete - response keys
    struct AutocompleteResponseKeys {
        static let Predictions: String = "predictions"
        static let Description: String = "description"
        static let Name: String = "main_text"
        static let Vincinity: String = "secondary_text"
        static let StructuredFormat: String = "structured_formatting"
    }
    
    // Location - keys
    struct LocationSearchKeys {
        static let ApiKey: String = "key"
        static let Radius: String = "radius"
        static let Query: String = "query"
        static let Location: String = "location"
        static let Language: String = "language"
    }
    
    // Location - values
    struct LocationSearchValues {
        static var Query: String = "" // get from user
        static let Radius: String = "50000"
        static let Language: String = "en"
        static let Location: String = "41.8781,-87.6298" // chicago lat,lon
    }
    
    // Location - response keys
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
