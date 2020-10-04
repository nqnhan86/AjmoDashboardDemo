//
//  DiscoverHeaderView.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/4/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit

class DiscoverHeaderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ColorManager.darkGreen
    }
    
    static func instance() -> DiscoverHeaderView? {
        if let vw = Bundle.main.loadNibNamed("DiscoverHeaderView", owner: nil, options: nil)?.first as? DiscoverHeaderView {
            return vw
        }
        
        return nil
    }
}
