//
//  Navigation.swift
//  LookLoc
//
//  Created by pengQueenie on 2017/8/26.
//  Copyright © 2017年 pengQueenie. All rights reserved.
//

import UIKit

struct Navigation {
    static let Title = "LookLoc."
    static let Font = "GillSans-Bold"
    static let FontColor = UIColor.white
    static var FontSize: CGFloat = 25
    static let TextAttributes = [NSForegroundColorAttributeName: FontColor,
                                 NSFontAttributeName: UIFont(name: Font, size: FontSize)!]
}

extension Navigation {
    static func addNavigation(_ vc: UIViewController) {
        let nav = vc.navigationController?.navigationBar
        vc.navigationItem.title = Navigation.Title
        nav?.titleTextAttributes = Navigation.TextAttributes
        vc.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // set default is translucent
        vc.navigationController?.navigationBar.isTranslucent = true
    }
}
