//
//  AlertViewManager.swift
//  SwiftAppTemplate
//
//  Created by Nhan iOS on 7/18/17.
//  Copyright © 2017 Nhan Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class AlertViewManager {
    static func showActionSheet(actions: [UIAlertAction]) {
        
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //menu.view.tintColor = ColorManager.color4A_4A_4A
        for action in actions {
            menu.addAction(action)
        }
        
        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        show(alertView: menu);
    }
    
    static func showAlertView(title: String,  message: String, actions: [UIAlertAction], cancelTitle: String){
        let menu = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //menu.view.tintColor = ColorManager.color4A_4A_4A
        for action in actions {
            menu.addAction(action)
        }
        
        menu.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        show(alertView: menu);
    }
    
    fileprivate static func show(alertView: UIAlertController) {
        if let topController = UIApplication.topViewController() {
            topController.present(alertView, animated: true, completion: nil)
        }
    }
}
