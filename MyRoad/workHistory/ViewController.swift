//
//  ViewController.swift
//  workHistory
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    var arr:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主页"
        arr = ["地图","其他","Helper"]
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()  //取消多余的空白行
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let title = arr[indexPath.row]
        switch title {
        case "地图":
            self.performSegueWithIdentifier("mainToMap", sender: nil)
        case"Helper":
            self.performSegueWithIdentifier("mainToAnoVC", sender: nil)
        default:
            print("未知")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

