//
//  PositionViewController.swift
//  workHistory
//
//  Created by 刘欣 on 16/6/14.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController,AMapLocationManagerDelegate {
    
    @IBOutlet weak var longLab: UILabel!
    @IBOutlet weak var latLab: UILabel!
    var locationManager:AMapLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "定位"
        location()
    }
    func location(){
        self.locationManager = AMapLocationManager()
        self.locationManager.delegate = self
        //持续定位
        self.locationManager.startUpdatingLocation()
        //(单次定位)此方法在开启定位下 不执行
        self.locationManager.requestLocationWithReGeocode(true) { (location, regeocode, error) in
            //regeocode 逆地理编码
        }
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print("lat:\(location.coordinate.latitude),long:\(location.coordinate.longitude)")
        latLab.text = String(location.coordinate.latitude)
        longLab.text = String(location.coordinate.longitude)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
