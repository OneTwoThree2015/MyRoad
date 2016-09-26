//
//  DrawingViewController.swift
//  workHistory
//
//  Created by Elley on 16/9/26.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "绘图"
        // Do any additional setup after loading the view.
        
        let drawing = Drawing(frame: CGRectMake(20,80,self.view.frame.width,self.view.frame.height))
        drawing.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(drawing)
        
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
