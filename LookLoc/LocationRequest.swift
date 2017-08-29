//
//  LocationRequest.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation

struct LocationRequest {
        
    // autoComplete example
    // https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0&input=volare&offset=3&location=41.8781,-87.6298&radius=50000
    
    var autoCompleteURL: Foundation.URL? {
        
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "maps.googleapis.com"
            urlComponents.path = "/maps/api/place/autocomplete/json"
            urlComponents.query = autocompleteQueryURL()
            
            print(urlComponents.url!)
            return urlComponents.url
    }
    
    
    // location example
    // https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyBMPCMhbVgfX6AKWlXKkjorH0Nw77J4eA0&location=41.8781,-87.6298&radius=50000&keyword=volare&language=en
    
    var locationURL: Foundation.URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "maps.googleapis.com"
        urlComponents.path = "/maps/api/place/textsearch/json"
        urlComponents.query = locationQueryURL()
        
        print(urlComponents.url!)
        return urlComponents.url
    }
}

// MARK: - query urls

extension LocationRequest {
    
    // auto complete query
    func autocompleteQueryURL() -> String {
        let methodParameters = [
            Constants.AutocompleteSearchKeys.ApiKey: Constants.ApiKey,
            Constants.AutocompleteSearchKeys.Location: Constants.AutocompleteSearchValues.Location,
            Constants.AutocompleteSearchKeys.Radius: Constants.AutocompleteSearchValues.Radius,
            Constants.AutocompleteSearchKeys.OffSet: Constants.AutocompleteSearchValues.OffSet,
            Constants.AutocompleteSearchKeys.Input: Constants.AutocompleteSearchValues.Input
            ] as [String: Any]
        
        let autocompleteQuery = escapedParameters(methodParameters as [String: AnyObject])
        return autocompleteQuery
    }
    
    // restaurant query
    func locationQueryURL() -> String {
        let methodParameters = [
            Constants.LocationSearchKeys.ApiKey: Constants.ApiKey,
            Constants.LocationSearchKeys.Language: Constants.LocationSearchValues.Language,
            Constants.LocationSearchKeys.Location: Constants.LocationSearchValues.Location,
            Constants.LocationSearchKeys.Radius: Constants.LocationSearchValues.Radius,
            Constants.LocationSearchKeys.Query: Constants.LocationSearchValues.Query
            ] as [String: Any]
        
        let restaurantQuery = escapedParameters(methodParameters as [String: AnyObject])
        return restaurantQuery
    }
    
    // setup key-value pairs
    func escapedParameters(_ parameters: [String: AnyObject]) -> String {
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            for (key, value) in parameters {
                let stringValue = "\(value)"
                keyValuePairs.append(key + "=" + "\(stringValue)")
            }
            return "\(keyValuePairs.joined(separator: "&"))"
        }
    }
}




