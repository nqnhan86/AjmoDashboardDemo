//
//  TodayHeaderView.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/3/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit

public typealias TodayHeaderActionBlock = (()->Void)

class TodayHeaderView: UIView {
    @IBOutlet fileprivate weak var lblNumber : UILabel!
    @IBOutlet fileprivate weak var imageView : UIImageView!
    
    fileprivate var actionBlock : TodayHeaderActionBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.createCircleShape()
    }
    
    static func instance(with action: TodayHeaderActionBlock? = nil) -> TodayHeaderView? {
        if let vw = Bundle.main.loadNibNamed("TodayHeaderView", owner: nil, options: nil)?.first as? TodayHeaderView {
            vw.actionBlock = action
            return vw
        }
        
        return nil
    }
    
    @IBAction fileprivate func pressActionButton(_ sender:UIButton){
        self.actionBlock?()
    }
    
    func setText(with number: String) {
        self.lblNumber.text = number
    }
}
