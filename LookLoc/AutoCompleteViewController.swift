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

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup cell hight
        self.TFSearch.placeholder = placeHolder
        self.TFSearch.delegate = self
        self.AutoCompleteTableView.delegate = self
        self.AutoCompleteTableView.dataSource = self
        AutoCompleteTableView!.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        addNavigation()
        
        // self-sizing table view cell
        AutoCompleteTableView.estimatedRowHeight = 120
        AutoCompleteTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func addNavigation() {
        let nav = self.navigationController?.navigationBar
        self.navigationItem.title = Navigation.Title
        nav?.titleTextAttributes = Navigation.TextAttributes
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // set default is translucent
        self.navigationController?.navigationBar.isTranslucent = true
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
        let substring = (self.TFSearch.text! as NSString).replacingCharacters(in: range, with: string)
        
        Constants.AutocompleteSearchValues.Input = substring.lowercased()

        getAutoComplete()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TFSearch.resignFirstResponder()
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
        TFSearch.resignFirstResponder()
//        self.performSegue(withIdentifier: "", sender: self)
    }
}

