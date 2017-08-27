//
//  LocationDetailViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/27.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var LocationTableView: UITableView!
    
    fileprivate var locationDetails = [LocationDetail]()
    
    // cell
    fileprivate let reuseIdentifier = "LocationCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
    }
    
    func getLocation() {
        let locClient = LocationClient()
        locClient.locationDetail(query: Constants.LocationSearchValues.Query) { (results, error) in
            if let error = error {
                print("error: \(error)")
            }
            guard let results = results else { return }
            print("results: \(results.count)")
            self.locationDetails = results
        }
    }
}
