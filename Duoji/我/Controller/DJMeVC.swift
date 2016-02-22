//
//  MeVC.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/2.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJMeVC: DJBaseTableVC {

    var headerView: UIView?
    var userHead: UILabel?
    var userAccount: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    
    func initUI() {
        self.tableView.backgroundColor = DJTheme.kDJColorTableViewbg
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: kDJScreenWidth, height: kDJScreenWidth*3/5))
        headerView?.backgroundColor = DJTheme.kDJColorMain
        
        userHead = DJTheme.getIconFont("\u{e611}", size: 88)
        userHead?.textColor = UIColor.whiteColor()
        userHead?.userInteractionEnabled = true
        if let userHead = userHead {
           headerView?.addSubview(userHead)
            userHead.snp_makeConstraints(closure: { [weak self](make) -> Void in
                make.centerX.equalTo(self!.headerView!)
                make.size.equalTo(CGSize(width: 88, height: 88))
                make.centerY.equalTo(self!.headerView!.snp_centerY).offset(-20)
                })
        }
        
        let account = UILabel()
        account.text = DJUser.name()
        userAccount = account
        userAccount?.textColor = UIColor.whiteColor()
        userAccount?.sizeToFit()
        let size = userAccount?.frame.size
        headerView?.addSubview(userAccount!)
        userAccount?.snp_makeConstraints(closure: { [weak self](make) -> Void in
            make.centerX.equalTo(self!.headerView!)
            make.top.equalTo(self!.userHead!.snp_bottom).offset(20)
            make.size.equalTo(size!)
        })
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        if section == 1 {
            return 1
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return self.headerView!.height+kDJTableViewSpace
        }
        return kDJTableViewSpace
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.headerView!.width, height: self.headerView!.height+10))
            view.backgroundColor = DJTheme.kDJColorTableViewbg
            view.addSubview(self.headerView!)
            return view
        }
        return nil
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MECELL") as? DJMeCell
        if cell == nil {
            cell = DJMeCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MECELL")
        }
        if let cell = cell {
            switch indexPath.section {
            case 0:
                if indexPath.row == 0 {
                    cell.title = "设置提醒"
                }
                if indexPath.row == 1 {
                    cell.title = "关于多记"
                }
                cell.lblTitle.textColor = UIColor.blackColor()
                cell.lblTitle.textAlignment = .Left
            case 1:
                cell.title = "退出"
                cell.lblTitle.textColor = UIColor.redColor()
                cell.lblTitle.textAlignment = .Center
            default:
                break
            }
            if indexPath.row == 0 {
                let lineTop = UIView(frame: CGRect(x: 0, y: 0, width: kDJScreenWidth, height: 0.5))
                lineTop.backgroundColor = DJTheme.kDJColorLine
                cell.addSubview(lineTop)
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(DJReminderVC(), animated: true)
                break
            case 1:
                self.navigationController?.pushViewController(DJAboutVC(), animated: true)
                break
            default:
                break
            }
        }
        if indexPath.section == 1 {
            //logout
        }
    }
}
