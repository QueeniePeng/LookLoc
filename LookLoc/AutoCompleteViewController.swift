//
//  AutoCompleteViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class AutoCompleteViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    // UI
    @IBOutlet weak var TFSearch: UITextField!
    @IBOutlet weak var AutoCompleteTableView: UITableView!
    
    // cell
    fileprivate let reuseIdentifier = "AutoCompleteCell"
    fileprivate var autoCompletes = [AutoComplete]()
    
    // text field
    fileprivate let placeHolder: String = "Search"
    
    // segue
    fileprivate let locationDetailSegue: String = "ShowLocationDetail"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TFSearch.placeholder = placeHolder
        self.TFSearch.delegate = self
        self.AutoCompleteTableView.delegate = self
        self.AutoCompleteTableView.dataSource = self
        AutoCompleteTableView!.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Navigation.addNavigation(self)
        
        // self-sizing table view cell
        AutoCompleteTableView.estimatedRowHeight = 120
        AutoCompleteTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getAutoComplete() {
        autoCompletes.removeAll(keepingCapacity: false)
        let locClient = LocationClient()
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

// MARK: - Text Field

extension AutoCompleteViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        AutoCompleteTableView!.isHidden = false
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        Constants.AutocompleteSearchValues.Input = substring.lowercased()

        getAutoComplete()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // stack over flow - https://stackoverflow.com/questions/29398678/encoding-url-using-swift-code
        let query = (textField.text)?.replacingOccurrences(of: ",", with: " ")
        Constants.LocationSearchValues.Query = (query?.lowercased())!
        TFSearch.resignFirstResponder()
        self.performSegue(withIdentifier: locationDetailSegue, sender: self)
        
        return true
    }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? AutoCompleteCell
        TFSearch.text = selectedCell?.LBName.text
        
        // escaped keyword
        var querys = autoCompletes[indexPath.row].description
        querys = querys.replacingOccurrences(of: ",", with: "")
        Constants.LocationSearchValues.Query = (querys.lowercased())
        
        print("keyword: \(Constants.LocationSearchValues.Query)")
        TFSearch.resignFirstResponder()
        
        // segue
        self.performSegue(withIdentifier: locationDetailSegue, sender: self)
    }
}

