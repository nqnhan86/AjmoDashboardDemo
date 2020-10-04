//
//  TodayDetailViewController.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/4/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit
import ParallaxHeader

class TodayDetailViewController: UIViewController {
    @IBOutlet weak var tblMain : UITableView!
    
    private var headerImageView : UIImageView!
    
    var todayEvent : AjmoTodayModel?
    
    private func setupParallaxHeader() {
        
        self.headerImageView = UIImageView()
        self.headerImageView.contentMode = .scaleAspectFill
        if let item = self.todayEvent {
            self.headerImageView.sd_setImage(with: item.pictureUrl)
        }
        
        self.tblMain.parallaxHeader.view = headerImageView
        self.tblMain.parallaxHeader.height = 300
        self.tblMain.parallaxHeader.minimumHeight = 0
        self.tblMain.parallaxHeader.mode = .fill
        self.tblMain.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            print(parallaxHeader.progress)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "Details"
        self.setupParallaxHeader()
    }
}

extension TodayDetailViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let item = self.todayEvent {
            cell.textLabel?.text = item.name
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
