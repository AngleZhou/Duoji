//
//  DJBaseTableVC.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/9.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJBaseTableVC: DJBaseVC, UITableViewDataSource,UITableViewDelegate {
    var tableView: UITableView

    override init() {
        let frame = CGRect(x: 0, y: 0, width: kDJScreenWidth, height: kDJScreenHeight)
        let tv = UITableView(frame: frame, style: UITableViewStyle.Grouped)
        tv.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        tv.backgroundColor = UIColor.whiteColor()
        tableView = tv
        
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        let frame = CGRect(x: 0, y: 0, width: kDJScreenWidth, height: kDJScreenHeight)
        let tv = UITableView(frame: frame, style: UITableViewStyle.Grouped)
        tv.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        tv.backgroundColor = UIColor.whiteColor()
        tableView = tv
        super.init(coder: aDecoder)
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView)
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "BASECELL"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = DJBaseTableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        return cell!
    }
    
}
