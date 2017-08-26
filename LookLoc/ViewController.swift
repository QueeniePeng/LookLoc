//
//  ViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var autoCompletes = [AutoComplete]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locClient = LocationClient()
        Constants.AutocompleteSearchValues.Input = "volare"
        Constants.RestaurantSearchValues.keyword = "volare"
        locClient.autoComplete(input: Constants.AutocompleteSearchValues.Input) { (results, error) in
            if let error = error {
                print("error: \(error)")
            }
            guard let results = results else { return }
            self.autoCompletes = results
            print("results: \(results.count)")
        }
    }
}

