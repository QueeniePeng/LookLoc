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
        
        // reachability
        Alert.addReachability(self)
        
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
            if let results = results {
                print("results: \(results.count)")
                if results.count > 0 {
                    self.locationDetails = results
                    self.LocationTableView.reloadData()
                
                // handle zero results return
                } else {
                    Alert.showZeroResultAlert(self)
                }
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! LocationDetailCell
        let address = selectedCell.LBAddress.text
        let name = selectedCell.LBName.text
        if address == "" || (address?.isEmpty)! {
        } else {
            openMapApp(name: name!, address: address!)
        }
    }
}


// MARK: - Map

extension LocationDetailViewController {
    
    // direction
    func openMapApp(name: String, address: String) {
        
        let mapActionSheet = UIAlertController(title: "Direction to \(name)?", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // apple map
        let appleMapAction = UIAlertAction(title: "Apple Map", style: UIAlertActionStyle.default) { (action) in
            
            // open apple map
            let convertedAddress = address.components(separatedBy: .whitespaces).joined(separator: "%20")
            let appleMapString = "http://maps.apple.com/?address=" + convertedAddress
            guard let appleMapURL = URL(string: appleMapString) else { return }
            
            if UIApplication.shared.canOpenURL(appleMapURL) {
                UIApplication.shared.open(appleMapURL, options: [:], completionHandler: nil)
            }
        }
        
        // cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
            mapActionSheet.dismiss(animated: true, completion: nil)
        }
        
        // add actions to action sheet
        mapActionSheet.addAction(appleMapAction)
        mapActionSheet.addAction(cancelAction)
        self.present(mapActionSheet, animated: true, completion: nil)
    }
}

