//
//  TweetsVC.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/8.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import JSONModel

class DJTweetsVC: DJBaseTableVC {
    
    var btnAdd:UILabel!
    
    var tweets: [DJTweet]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "笔记"
        self.btnAdd = DJTheme.getIconFont("\u{e605}", size: 48.0)
//        DJTheme.setIconFont(self.btnAdd, iconName: "\u{e605}", size: 48)
//        self.btnAdd.setTitle("\u{e605}", forState: UIControlState.Normal) //DJTheme.getIconFont(, size: 48.0)
        self.btnAdd.textColor = DJTheme.kDJColorMain
        
        self.btnAdd.backgroundColor = UIColor.greenColor()
//        self.btnAdd.titleLabel?.textColor = DJTheme.kDJColorMain
        self.btnAdd.layer.cornerRadius = 24
        self.btnAdd.layer.masksToBounds = true
        self.view.addSubview(self.btnAdd)
        self.btnAdd.snp_makeConstraints { [weak self](make) -> Void in
            make.trailing.equalTo(self!.view).offset(-20.0)
            make.bottom.equalTo(self!.view).offset(-20.0)
            make.size.equalTo(CGSizeMake(48.0, 48.0))
        }
//        self.btnAdd.layer.zPosition = 2
        self.view.bringSubviewToFront(self.btnAdd)
//
        self.btnAdd.userInteractionEnabled = true
        let tapAdd = UITapGestureRecognizer(target: self, action: "newTweet:")
        
        self.btnAdd.addGestureRecognizer(tapAdd)
        
        self.loadTweets()
        //搜索
//        self.actionCustomLeftBtnWithNrlImage(nil, htlImage: nil, title: "搜索", action: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        //设置
        self.actionCustomRightBtnWithNrlImage("\u{e60c}", htlImage: nil, title: nil) {[weak self] in
            let meVc = DJMeVC()
            self!.navigationController?.pushViewController(meVc, animated: true)
        }


    }
    
    func newTweet(sender:UITapGestureRecognizer) {
        let newVC = DJTweetDetailVC()
        newVC.isNew = true
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func right() {
        
    }
    
    func loadTweets() {
        DJTweetsModel.getTweets({ [weak self](result: [String : AnyObject]?) -> Void in
            let arr = result!["data"] as! Array<[String:AnyObject]>
            let test = arr[0] as [String:AnyObject]
            let model: DJTweetsModel?
                model =  DJTweetsModel.init(dictionary: result)
                if model!.success == 1 {
                    self!.tweets = model!.data
                    self!.navigationItem.title = String.init(format: "笔记(%d)", model!.data!.count)
                    self!.tableView.reloadData()
                }
                else {
                    TOAST_MSG(model!.errorMsg!)
                }
            
            
            }) { (requestErr) -> Void in
                TOAST_ERROR(requestErr!)
        }
    }
    
    //MARK: - TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = tweets {
            return arr.count
        }
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "DJTweetCell"
        var cell : DJTweetCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? DJTweetCell
        if cell == nil {
            cell = DJTweetCell(style: .Default, reuseIdentifier: identifier)
        }
        if let arr = tweets {
            let data = arr[indexPath.row]
            cell?.title = data.content
        }
        
    
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! DJTweetCell
        return cell.height
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailvc = DJTweetDetailVC()
        let test = self.tweets![indexPath.row]
        detailvc.tweet = test
        detailvc.isNew = false
        self.navigationController?.pushViewController(detailvc, animated: true)
    }
}
