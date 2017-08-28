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
    static func showConnectionAlert(_ viewController: UIViewController) {
        let alertController = UIAlertController(title: "Please connect to internet and try again", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        viewController.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
