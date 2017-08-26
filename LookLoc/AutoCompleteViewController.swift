//
//  AutoCompleteViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class AutoCompleteViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var TFSearch: UITextField!
    @IBOutlet weak var AutoCompleteTableView: UITableView!
    
    fileprivate let reuseIdentifier = "AutoCompleteCell"
    fileprivate var autoCompletes = [AutoComplete]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup cell hight
        AutoCompleteTableView.rowHeight = self.view.frame.height / 7
        self.AutoCompleteTableView.delegate = self
        self.AutoCompleteTableView.dataSource = self
        getAutoComplete()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let nav = self.navigationController?.navigationBar
        self.navigationItem.title = Navigation.Title
        nav?.titleTextAttributes = Navigation.TextAttributes
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // set default is translucent
        self.navigationController?.navigationBar.isTranslucent = true
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
            self.AutoCompleteTableView.reloadData()
        }
    }
}

extension AutoCompleteViewController {
    
}


// MARK: - UITableViewDataSource

extension AutoCompleteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompletes.count
    }
    
    // config business cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AutoCompleteCell
        let autoComplete = autoCompletes[indexPath.row]
        cell.LBName.text = autoComplete.name
        cell.LBVincinity.text = autoComplete.vincinity
        return cell
    }
}

