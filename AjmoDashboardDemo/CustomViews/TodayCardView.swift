//
//  TodayCardView.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/3/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit
import SDWebImage

class TodayCardView: UIView {
    @IBOutlet private weak var vwContent : UIView!
    @IBOutlet private weak var ivPicture : UIImageView!
    @IBOutlet private weak var lblTitle : UILabel!
    @IBOutlet private weak var lblSubtitle : UILabel! //time * venue_name * city
    
    @IBOutlet private weak var vwCalendar : UIView!
    @IBOutlet private weak var lblMonth : UILabel!
    @IBOutlet private weak var lblDay : UILabel!
    
    @IBOutlet private weak var vwGradient : UIView!
    
    static func instance() -> TodayCardView? {
        if let vw = Bundle.main.loadNibNamed("TodayCardView", owner: nil, options: nil)?.first as? TodayCardView {
           
            return vw
        }
        
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }

    private func setupUI() {
        self.vwContent.createRoundCorner(10)
        self.vwCalendar.createRoundCorner(7)
        self.vwGradient.addGradientLayer(with: .black)
    }
    
    func loadData(_ data: AjmoTodayModel) {
        self.ivPicture.sd_setImage(with: data.pictureUrl)
        self.lblTitle.text = data.name
        
        var subTitle = ""
        if let d = data.startDate {
            subTitle = d.formatDateTime(Constants.TIME_FORMAT)
            self.lblMonth.text = d.formatDateTime(Constants.MONTH_SHORT_FORMAT)
            self.lblDay.text = d.formatDateTime(Constants.DAY_FORMAT)
        }

        if let name = data.venueName {
            subTitle += "    \u{2022}    \(name)" //\u{2022} = bullet symbol
        }
        
        if let city = data.city {
            subTitle += "    \u{2022}    \(city)" //\u{2022} = bullet symbol
        }
        
        self.lblSubtitle.text = subTitle
    }
}
