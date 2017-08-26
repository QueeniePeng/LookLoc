//
//  AutoCompleteViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class AutoCompleteViewController: UIViewController {
    
    @IBOutlet weak var TFSearch: UITextField!
    @IBOutlet weak var AutoCompleteTableView: UITableView!
    
    fileprivate let reuseIdentifier = "AutoCompleteCell"
    fileprivate var autoCompletes = [AutoComplete]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getAutoComplete() {
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
        AutoCompleteTableView.reloadData()
    }
}

