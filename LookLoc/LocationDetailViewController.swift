//
//  LocationDetailViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/27.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var LocationTableView: UITableView!
    
    fileprivate var locationDetails = [LocationDetail]()
    
    // cell
    fileprivate let reuseIdentifier = "LocationCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationTableView.dataSource = self
        LocationTableView.delegate = self
        getLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // navigation
        Navigation.addNavigation(self)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        
        // self-sizing table view cell
        LocationTableView.estimatedRowHeight = 160
        LocationTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getLocation() {
        locationDetails.removeAll(keepingCapacity: false)
        let locClient = LocationClient()
        locClient.locationDetail(query: Constants.LocationSearchValues.Query) { (results, error) in
            if let error = error {
                print("error: \(error)")
            }
            guard let results = results else { return }
            print("results: \(results.count)")
            self.locationDetails = results
            self.LocationTableView.reloadData()
        }
    }
}

extension LocationDetailViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationDetails.count
    }
    
    // config location detail cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationDetailCell
        let locationDetail = locationDetails[indexPath.row]
        
        var openNow: String
        if (locationDetail.openNow) == true {
            openNow = "OPEN"
        } else {
            openNow = "CLOSED"
        }
        
        let url = URL(string:locationDetail.icon)
        let data = try? Data(contentsOf: url!)
        let icon: UIImage = UIImage(data: data!)!
        
        
        // TODO: clean up
        let types = locationDetail.types
        if types.count > 0 {
            cell.LBTypeOne.isHidden = false
            cell.LBTypeOne.text = types[0]
        } else {
            cell.LBTypeOne.isHidden = true
        }
        
        cell.IVIcon.image = icon
        cell.LBAddress.text = locationDetail.address
        cell.LBName.text = locationDetail.name
        cell.LBRating.text = String(locationDetail.rating)
        cell.LBOpenNow.text = openNow
        
        return cell
    }
}
