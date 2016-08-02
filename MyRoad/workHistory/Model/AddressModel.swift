//
//  AddressModel.swift
//  workHistory
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class AddressModel: NSObject {
    var name:String!
    var address:String!
    var location:CLLocationCoordinate2D!
    var distance:Int!
    override init() {
        super.init()
    }

}
