//
//  TweetsVC.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/8.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import JSONModel
import MJRefresh

class DJTweetsVC: DJBaseTableVC, DJTweetReturnDelegate {
    
    var btnAdd:UILabel!
    var refreshHeader:MJRefreshNormalHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.loadTweets()
        //搜索
//        self.actionCustomLeftBtnWithNrlImage(nil, htlImage: nil, title: "搜索", action: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
    }
    
    func initUI() {
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self]() -> Void in
            self?.loadTweets()
        })
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "笔记"
        self.btnAdd = DJTheme.getIconFont("\u{e605}", size: 48.0)
        self.btnAdd.textColor = DJTheme.kDJColorMain
        self.btnAdd.backgroundColor = UIColor.whiteColor()
        self.btnAdd.layer.cornerRadius = 24
        self.btnAdd.layer.masksToBounds = true
        self.view.addSubview(self.btnAdd)
        self.btnAdd.snp_makeConstraints { [weak self](make) -> Void in
            make.trailing.equalTo(self!.view).offset(-20.0)
            make.bottom.equalTo(self!.view).offset(-20.0)
            make.size.equalTo(CGSizeMake(48.0, 48.0))
        }
        self.btnAdd.userInteractionEnabled = true
        let tapAdd = UITapGestureRecognizer(target: self, action: "newTweet:")
        self.btnAdd.addGestureRecognizer(tapAdd)
        
        self.actionCustomRightBtnWithNrlImage("\u{e60c}", htlImage: nil, title: nil) {[weak self] in
            let meVc = DJMeVC()
            self!.navigationController?.pushViewController(meVc, animated: true)
        }
    }

    
    func newTweet(sender:UITapGestureRecognizer) {
        let newVC = DJTweetDetailVC()
        newVC.isNew = true
        newVC.delegate = self
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.bringSubviewToFront(self.btnAdd)
        if DJTweetsModel.sharedInstance.data != nil {
            self.navigationItem.title = String.init(format: "笔记(%d)", DJTweetsModel.sharedInstance.data!.count)
        }
        
        self.tableView.reloadData()
    }
    
    func right() {
        
    }
    
    func loadTweets() {
        DJTweetsModel.getTweets({ [weak self](result: [String : AnyObject]?) -> Void in
            self?.tableView.mj_header.endRefreshing()
            let model: DJTweetsModel?
                model =  DJTweetsModel.init(dictionary: result)
                if model!.success == 1 {
                    DJTweetsModel.sharedInstance.data = model!.data
                    self!.navigationItem.title = String.init(format: "笔记(%d)", model!.data!.count)
                    self!.tableView.reloadData()
                }
                else {
                    TOAST_MSG(model!.error_msg!)
                }
            
            
            }) { [weak self](requestErr) -> Void in
                TOAST_ERROR(requestErr!)
                self?.tableView.mj_header.endRefreshing()
        }
    }
    
    //MARK: - TweetDelegate
    func DJTweetReturn(tweet: DJTweet) {
        DJTweetsModel.sharedInstance.data?.insert(tweet, atIndex: 0)
        self.tableView.reloadData()
    }
    
    //MARK: - TableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = DJTweetsModel.sharedInstance.data {
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
        if let arr = DJTweetsModel.sharedInstance.data {
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
        let test = DJTweetsModel.sharedInstance.data![indexPath.row]
        detailvc.tweet = test
        detailvc.isNew = false
        self.navigationController?.pushViewController(detailvc, animated: true)
    }
}
