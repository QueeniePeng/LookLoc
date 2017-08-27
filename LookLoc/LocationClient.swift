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
                
                var autoCompletes = [AutoComplete]()
                guard let status = JSON[Constants.Status] as? String else { return }
                if status == "OK" {
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
                    print("Status is not OK")
                }
            }
        }
    }
    
//    func location
}
