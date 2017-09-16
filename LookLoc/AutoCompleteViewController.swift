//
//  AutoCompleteViewController.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class AutoCompleteViewController: UIViewController {
    
    // UI - textField, tableView
    @IBOutlet weak var TFSearch: UITextField!
    @IBOutlet weak var AutoCompleteTableView: UITableView!
    
    // cell
    fileprivate let reuseIdentifier = "AutoCompleteCell"
    fileprivate var autoCompletes = [AutoComplete]()
    
    // text field
    fileprivate let placeHolder: String = "Search"
    
    // segue
    fileprivate let locationDetailSegue: String = "ShowLocationDetail"
    
    let reachability = Reachability()!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reachability
        reachability.whenReachable = { _ in
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
    
    func setUpView() {
        TFSearch.placeholder = placeHolder
        TFSearch.delegate = self
        AutoCompleteTableView.delegate = self
        AutoCompleteTableView.dataSource = self
        AutoCompleteTableView!.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // navigation
        Navigation.addNavigation(self)
                
        // self-sizing table view cell
        AutoCompleteTableView.estimatedRowHeight = 120
        AutoCompleteTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getAutoComplete() {
        let locClient = LocationClient()
        locClient.autoComplete(input: Constants.AutocompleteSearchValues.Input) { (results, error) in
            if let error = error {
                print("error: \(error)")
            }
            guard let results = results else { return }
            self.autoCompletes.removeAll()
            self.autoCompletes = results
            print("results: \(results.count)")
            self.AutoCompleteTableView.reloadData()
        }
    }
}

// MARK: - Text Field

extension AutoCompleteViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // stack over flow: https://stackoverflow.com/questions/24015848/using-stringbyreplacingcharactersinrange-in-swift
        if (textField.text?.characters.count)! > 0 {
            let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            // check if substring length lower than require offset: 3
            if substring.characters.count < Int(Constants.AutocompleteSearchValues.OffSet)! {
            } else {
                self.AutoCompleteTableView!.isHidden = false
                Constants.AutocompleteSearchValues.Input = substring.lowercased()
                self.getAutoComplete()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        let query = (textField.text)?.replacingOccurrences(of: ",", with: " ")
        Constants.LocationSearchValues.Query = (query?.lowercased())! // store user input
        TFSearch.resignFirstResponder()
        self.performSegue(withIdentifier: locationDetailSegue, sender: self)
        
        return true
    }
    
    // stack over flow: https://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-uitextfield
    // dismiss keyboard when touch outside of textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let subviews = self.view.subviews
        for (_, objects) in subviews.enumerated() {
            if objects.isKind(of: UITextField.self) {
                let textField = objects
                if objects.isFirstResponder {
                    textField.resignFirstResponder()
                }
            }
        }
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
    
    // config auto complete cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AutoCompleteCell
        let autoComplete = autoCompletes[indexPath.row]
        cell.LBName.text = autoComplete.name
        cell.LBVincinity.text = autoComplete.vincinity
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AutoCompleteViewController: UITableViewDelegate {
    // select auto complete cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? AutoCompleteCell
        TFSearch.text = selectedCell?.LBName.text
        
        // handle query
        var querys = autoCompletes[indexPath.row].description
        querys = querys.replacingOccurrences(of: ",", with: "")
        Constants.LocationSearchValues.Query = (querys.lowercased()) // store user input
        
        print("Query: \(Constants.LocationSearchValues.Query)")
        TFSearch.resignFirstResponder()
        
        // segue
        self.performSegue(withIdentifier: locationDetailSegue, sender: self)
    }
}

// MARK: - Memory

extension AutoCompleteViewController {

    override func didReceiveMemoryWarning() {
        Memory.clearMemory()
        super.didReceiveMemoryWarning()
    }
}
