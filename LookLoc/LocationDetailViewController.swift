//
//  LocationDetailViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/27.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController, UITableViewDelegate {
    
    // UI - tableView
    @IBOutlet weak var LocationTableView: UITableView!
    
    fileprivate var locationDetails = [LocationDetail]()
    
    // cell
    fileprivate let reuseIdentifier = "LocationCell"
    fileprivate enum OpenNow: String {
        case OPEN = "OPEN", CLOSED = "CLOSED"
    }
    
    override func viewDidLoad() {
        
        LocationTableView.dataSource = self
        LocationTableView.delegate = self
        
        // reachability
        let reachability = Reachability()!
        reachability.whenReachable = { _ in
            self.getLocation()
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                Alert.showConnectionAlert(self)
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        } 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // navigation
        Navigation.addNavigation(self)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        
        // self-sizing table view cell
        LocationTableView.estimatedRowHeight = 120
        LocationTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getLocation() {
        locationDetails.removeAll()
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

// MARK: - UITableViewDataSource

extension LocationDetailViewController: UITableViewDataSource {
    
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
            openNow = OpenNow.OPEN.rawValue
        } else {
            openNow = OpenNow.CLOSED.rawValue
        }
        
        // parse icon image
        let url = URL(string:locationDetail.icon)
        let data = try? Data(contentsOf: url!)
        let icon: UIImage = UIImage(data: data!)!
        
        // TODO: display more types
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
    
    // select location detail cell to call map
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
    
    func openMapApp(name: String, address: String) {
        
        let mapActionSheet = UIAlertController(title: "Direction to \(name)?", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // apple map button
        let appleMapAction = UIAlertAction(title: "Apple Map", style: UIAlertActionStyle.default) { (action) in
            
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
        
        mapActionSheet.addAction(appleMapAction)
        mapActionSheet.addAction(cancelAction)
        self.present(mapActionSheet, animated: true, completion: nil)
    }
}

// MARK: - Memory

extension LocationDetailViewController {
    
    override func didReceiveMemoryWarning() {
        Memory.clearMemory()
        super.didReceiveMemoryWarning()
    }
}

