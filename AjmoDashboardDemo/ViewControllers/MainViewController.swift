//
//  MainViewController.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 9/30/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var headerView : UIView!
    @IBOutlet private weak var tblMain : UITableView!
    @IBOutlet private weak var appearanceSwitch : UISwitch!
    private var refreshControl = RefreshControl()
    
    private var todayHeaderView : TodayHeaderView!
    private var items = [AjmoTodayModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.loadData()
    }
    
    
    private func setupUI() {
        self.headerView.backgroundColor = ColorManager.darkGreen
        
        self.tblMain.register(UINib(nibName: "TodayCardViewCell", bundle: nil), forCellReuseIdentifier: TodayCardViewCell.cellID)
        
        if #available(iOS 10.0, *) {
            self.tblMain.refreshControl = refreshControl
        } else {
            self.tblMain.addSubview(refreshControl)
        }
        
        if let tableHeader = DiscoverHeaderView.instance() {
            let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
            let view = UIView(frame: frame)
            
            tableHeader.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableHeader)
            
            view.addHorizontalConstraint(toView: tableHeader)
            view.addVerticalConstraint(toView: tableHeader)
            
            self.tblMain.tableHeaderView = view
        }
        
        refreshControl.backgroundColor = ColorManager.darkGreen
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    
    @objc
    private func loadData() {
        Utils.showHUDIn(vc: self)
        ApiManager.shared.fetchTodayData(success: { [unowned self](models) in
            Utils.hideHUDIn(vc: self)
            self.refreshControl.endRefreshing()
            self.items = models
            self.tblMain.reloadData()
        }) { [unowned self](error) in
            self.refreshControl.endRefreshing()
            Utils.hideHUDIn(vc: self)
            Utils.showAlert(in: self, title: "API Error", message: error, cancelButton: "OK")
            print(error)
        }
    }
    
    @IBAction func switchValueDidChanged(_ sender: UISwitch) {
        self.tblMain.reloadData()
    }
}

extension MainViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodayCardViewCell.cellID, for: indexPath) as! TodayCardViewCell
        cell.loadData(self.items, coverFlow: self.appearanceSwitch.isOn)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.8 * self.view.bounds.width
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.todayHeaderView == nil {
            self.todayHeaderView = TodayHeaderView.instance(with: {
                Utils.showAlert(message: "This feature isn't required any new skills than implemented ones. Therefore, I didn't work on it.", cancelButton: "That's OK")
            }) ?? TodayHeaderView()
        }
        
        self.todayHeaderView.setText(with: "\(self.items.count)")
        return self.todayHeaderView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
