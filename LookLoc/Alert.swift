//
//  Alert.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/28.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

// MARK: - Alert

struct Alert {

    // show connection Alert if not connected to wifi or cellar
    static func showConnectionAlert(_ vc: UIViewController) {
        let alertController = UIAlertController(title: "Please connect to internet and try again", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        vc.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // show zero results alert & return to last vc
    static func showZeroResultAlert(_ vc: UIViewController) {
        let alertController = UIAlertController(title: "Well I tried, but nothing matched the search", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        vc.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alertController.dismiss(animated: true, completion: nil)
                vc.navigationController?.popViewController(animated: true)
            }
        }
    }
}
