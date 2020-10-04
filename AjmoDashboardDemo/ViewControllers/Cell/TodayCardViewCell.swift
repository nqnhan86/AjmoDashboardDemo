//
//  TodayCardViewCell.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/3/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit
import iCarousel

class TodayCardViewCell: UITableViewCell {
    static var cellID = "TodayCardViewCellId"
    @objc @IBOutlet private weak var vwCard : iCarousel!
    
    private var items = [AjmoTodayModel]()
    private var sizeFactor : CGFloat = 0.95
    
    @objc override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    @objc private func setupUI() {
        self.vwCard.type = .invertedTimeMachine
        self.vwCard.isPagingEnabled = true
        self.vwCard.isVertical = false
        self.vwCard.bounceDistance = 0.1
        self.vwCard.ignorePerpendicularSwipes = true
    }
    
    @objc func loadData(_ data: [AjmoTodayModel], coverFlow: Bool = true) {
        if coverFlow {
            self.vwCard.type = .coverFlow2
        }
        else {
            self.vwCard.type = .invertedTimeMachine
        }
        
        self.items = data
        self.vwCard.reloadData()
    }
}

extension TodayCardViewCell: iCarouselDataSource, iCarouselDelegate {
    @objc func numberOfItems(in carousel: iCarousel) -> Int {
        return self.items.count
    }
    
    @objc func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var cardView : TodayCardView!
        
        if let vw = view as? TodayCardView {
            cardView = vw
        }
        else {
            cardView = TodayCardView.instance() ?? TodayCardView()
        }
        cardView.loadData(self.items[index])
        cardView.frame = CGRect(x: 0, y: 0, width: self.sizeFactor*self.vwCard.frame.width, height: self.sizeFactor*self.vwCard.frame.height)
        return cardView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == .spacing , self.vwCard.type == .invertedTimeMachine{
            return 0.7
        }
        
        return value
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if let topVC = UIApplication.topViewController() {
            SceneManager.navigateToTodayDetailScene(self.items[index], navigationController: topVC.navigationController!)
        }
    }
}
