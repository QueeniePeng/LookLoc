//
//  Alert.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/28.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

class Alert {

    // show connection Alert if not connected to wifi or cellar
    static func showConnectionAlert(_ vc: UIViewController) {
        let alertController = UIAlertController(title: "Please connect to internet and try again", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        vc.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    static func addReachability(_ vc: UIViewController) {
        let reachability = Reachability()!
        reachability.whenReachable = { _ in
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                Alert.showConnectionAlert(vc)
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
