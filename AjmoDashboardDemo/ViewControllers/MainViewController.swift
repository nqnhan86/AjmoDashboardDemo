//
//  MainViewController.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 9/30/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tblMain : UITableView!
    @IBOutlet private weak var appearanceSwitch : UISwitch!
    
    private var todayHeaderView : TodayHeaderView!
    private var items = [AjmoTodayModel]()
    fileprivate var cellHeight : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    
    private func setupUI() {
        self.cellHeight = 0.8 * (self.view.bounds.width - 32)
        self.tblMain.register(UINib(nibName: "TodayCardViewCell", bundle: nil), forCellReuseIdentifier: TodayCardViewCell.cellID)
    }
    
    private func loadData() {
        Utils.showHUDIn(vc: self)
        ApiManager.shared.fetchTodayData(success: { [unowned self](models) in
            Utils.hideHUDIn(vc: self)
            self.items = models
            self.tblMain.reloadData()
        }) { [unowned self](error) in
            Utils.hideHUDIn(vc: self)
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
