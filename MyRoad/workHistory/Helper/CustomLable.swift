//
//  CustomLable.swift
//  workHistory
//
//  Created by Elley on 16/6/28.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class CustomLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsetsZero))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
