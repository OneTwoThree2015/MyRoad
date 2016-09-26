//
//  FaceBookShareViewController.swift
//  workHistory
//
//  Created by Elley on 16/8/3.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class FaceBookShareViewController: UIViewController,FBSDKSharingDelegate {

    @IBOutlet weak var shareBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FaceBooK-Share"
        // Do any additional setup after loading the view.
        shareBtn.addTarget(self, action: #selector(share), forControlEvents: .TouchUpInside)
    }

    
    func share(){
        let share = FBSDKShareLinkContent()
        share.contentURL = NSURL(string: "https://cn.bing.com/")
        share.contentTitle = "这是搜索bing"
        
        share.imageURL = NSURL(string: "http://www.bz55.com/uploads/allimg/140912/138-1409120S912.jpg")
        share.contentDescription = "那好我们一起来使用下，看看怎么养呢"
        
        //支持web 和app
        FBSDKShareDialog.showFromViewController(self, withContent: share, delegate: self)
    }
    
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("取消分享")
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        
    }
    
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
