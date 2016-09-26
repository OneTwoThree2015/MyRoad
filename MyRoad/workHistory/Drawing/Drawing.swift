//
//  Drawing.swift
//  workHistory
//
//  Created by Elley on 16/9/26.
//  Copyright © 2016年 lx. All rights reserved.
//

import UIKit

class Drawing: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //获取上下文
        let content = UIGraphicsGetCurrentContext()
        //设置线条样式
        CGContextSetLineCap(content,.Square)
        //设置线的宽度
        CGContextSetLineWidth(content, 1)
        //设置线的颜色
        CGContextSetRGBStrokeColor(content, 1, 0, 0, 1)
        //设置一个起始路径
        CGContextBeginPath(content)
        
        //带圆角
        //设置起始坐标
        CGContextMoveToPoint(content, 45, 1)
        CGContextAddArcToPoint(content, 45, 1, 149, 1, 4)
        CGContextAddArcToPoint(content, 149, 1, 149, 149, 4)
        CGContextAddArcToPoint(content, 149, 149, 1, 149, 4)
        CGContextAddArcToPoint(content, 1, 149, 1, 1, 4)
        CGContextAddArcToPoint(content, 1, 1, 45, 1, 4)
        
        CGContextClosePath(content)  //如果是纯直线的话  不需要此行代码
        CGContextStrokePath(content)
        
        //直角长方形
        CGContextMoveToPoint(content, 154, 1)
        CGContextAddLineToPoint(content, 250, 1)
        CGContextAddLineToPoint(content, 250, 149)
        CGContextAddLineToPoint(content, 154, 149)
        CGContextAddLineToPoint(content, 154, 1)
        CGContextStrokePath(content)
        
        //圆形-填充
        let rect1 = CGRect(x: 1, y: 160, width: 150, height: 150)
        UIColor.whiteColor().set()
        CGContextFillRect(content, rect1)
        CGContextAddEllipseInRect(content, CGRectMake(1, 160, 150, 150))
        UIColor.orangeColor().set()
        CGContextFillPath(content)
        
        // 圆形-边框
        //(214,220) :圆心坐标点   50:半径
        CGContextAddArc(content, 214, 220, 50, 0, CGFloat(2 * M_PI), 0)
        CGContextDrawPath(content, .Stroke)
        
        //曲线
        CGContextMoveToPoint(content, 10, 400)
        //（80,480）(40,440) 任意两点    (150,350) 终点
        CGContextAddCurveToPoint(content, 80, 480, 40, 440, 150, 350)
        CGContextFillPath(content)
        
        
    }

}
