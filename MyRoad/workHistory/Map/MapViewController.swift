//
//  MapViewController.swift
//  workHistory
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class MapViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var mapTableView: UITableView!
    var nameArr:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地图应用"
        nameArr = ["搜索","定位","地图定位","其他"]
        mapTableView.delegate = self
        mapTableView.dataSource = self
        mapTableView.tableFooterView = UIView()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mapCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = nameArr[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let title = nameArr[indexPath.row]
        switch title {
        case "搜索":
            self.performSegueWithIdentifier("mapToSearch", sender: nil)
        case "定位":
            self.performSegueWithIdentifier("MapToPositionVC", sender: nil)
        default:
            print("未知")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
