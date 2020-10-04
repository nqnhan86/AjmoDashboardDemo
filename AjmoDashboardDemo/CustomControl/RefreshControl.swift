//
//  RefreshControl.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/4/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit
/*
 Solved issue with white line showed when pulled down tableview
 Reference: https://stackoverflow.com/questions/41331691/white-line-below-uirefreshcontrol-when-pulled-tableview?noredirect=1&lq=1
 */
class RefreshControl: UIRefreshControl {

   override var frame: CGRect {
        didSet {
            if frame.origin.y < 0 {
                isHidden = false
            } else {
                isHidden = true
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let originalFrame = frame
        frame = originalFrame
    }
}
