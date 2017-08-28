//
//  LocationClient.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import Foundation
import Alamofire

class LocationClient: NSObject {
    fileprivate var locationRequest = LocationRequest()
    
    // auto complete
    func autoComplete(input: String, completion: @escaping (_ results: [AutoComplete]?, _ error: NSError?) -> Void) {
        
        Alamofire.request(locationRequest.autoCompleteURL!).responseJSON { response in
            if let JSON = response.result.value as? [String: AnyObject] {
                print("json: \(JSON)")
                
                guard let status = JSON[Constants.Status] as? String else { return }
                if status == Constants.StatusValue.OK.rawValue {
                    var autoCompletes = [AutoComplete]()
                    guard let predictions = JSON[Constants.AutocompleteResponseKeys.Predictions] as? [[String: AnyObject]] else { return }
                    for prediction in predictions {
                        guard let description =  prediction[Constants.AutocompleteResponseKeys.Description] as? String else { return }
                        guard let formats = prediction[Constants.AutocompleteResponseKeys.StructuredFormat] as? [String: AnyObject] else { return }
                        guard let name = formats[Constants.AutocompleteResponseKeys.Name] as? String else { return }
                        guard let vincinity = formats[Constants.AutocompleteResponseKeys.Vincinity] as? String else { return }
                        
                        // store autocomplete results
                        let autoComplete = AutoComplete.init(name: name, vincinity: vincinity, description: description)
                        autoCompletes.append(autoComplete)
                        
                    }
                    OperationQueue.main.addOperation({
                        completion((autoCompletes), nil)
                    })
                } else {
                    print("Status is not OK: \n **********\n\(status)\n***********")
                }
            }
        }
    }
    
    func locationDetail(query: String, completion: @escaping (_ results: [LocationDetail]?, _ error: NSError?) -> Void) {
    
        Alamofire.request(locationRequest.locationURL!).responseJSON { response in
            if let JSON = response.result.value as? [String: AnyObject] {
                print("json: \(JSON)")
                
                var locationDetails = [LocationDetail]()
                guard let status = JSON[Constants.Status] as? String else { return }
                if status == Constants.StatusValue.OK.rawValue {
                    guard let results = JSON[Constants.LocationResponseKeys.Results] as? [[String: AnyObject]] else { return }
                    for result in results {
                    
                        guard let icon = result[Constants.LocationResponseKeys.Icon] as? String else { return }
                        guard let name = result[Constants.LocationResponseKeys.Name] as? String else { return }
                        guard let address = result[Constants.LocationResponseKeys.Formatted_Address] as? String else { return }
                        guard let types = result[Constants.LocationResponseKeys.Types] as? [String] else { return }

                        var openNow: Bool?
                        var rating: Float?
                        if let openHour = result[Constants.LocationResponseKeys.OpenHour] as? [String: AnyObject],
                           let open_Now = openHour[Constants.LocationResponseKeys.OpenNow] as? Bool,
                           let ratingFloat = result[Constants.LocationResponseKeys.Rating] as? Float {
                            openNow = open_Now
                            rating = ratingFloat
                        } else {
                            openNow = false
                            rating = 0.0
                        }
                        
                        let locationDetail = LocationDetail.init(icon: icon, name: name, rating: rating!, types: types, address: address, openNow: openNow!)
                        locationDetails.append(locationDetail)
                        
                        // TODO: 
//                        guard let photos = result[Constants.LocationResponseKeys.Photos] as? [String: AnyObject] else { return }
//                        guard let html = photos[Constants.LocationResponseKeys.Html] as? String else { return } // nest in photos
                    }
                    OperationQueue.main.addOperation({
                        completion((locationDetails), nil)
                    })
                
                } else {
                    print("Status is not OK: \n **********\n\(status)\n***********")
                    OperationQueue.main.addOperation({
                        completion((locationDetails), nil)
                    })
                }
            }
        }
    }
}
