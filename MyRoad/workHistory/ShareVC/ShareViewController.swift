//
//  ShareViewController.swift
//  workHistory
//
//  Created by Elley on 16/8/3.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arr = [String]()
    
    @IBOutlet weak var shareTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        arr = ["FaceBook-分享"]
        self.title = "分享"
        shareTableView.tableFooterView = UIView()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shareCell", forIndexPath: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let title = arr[indexPath.row]
        switch title {
        case "FaceBook-分享":
            self.performSegueWithIdentifier("shareToFBVC", sender: nil)
        default:
            print("未知")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
