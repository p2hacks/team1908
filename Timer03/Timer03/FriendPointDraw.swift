//
//  FriendPointDraw.swift
//  Timer03
//
//  Created by 藤内悠 on 2019/02/12.
//  Copyright © 2019 Jonny. All rights reserved.
//

import UIKit

class FriendPointDraw: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.*/
    
     open var FriendShip = 0.0//初期状態
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.magenta.setFill()
        UIColor.black.setStroke()
        
        let path = UIBezierPath(
            rect: CGRect(x: 20.0, y: 650.0, width: 100.0, height: -100.0 + FriendShip * 10.0)//ここのheightを時間に比例した値にしたい
            )
        
        path.lineWidth = 3.0
        
        path.fill()
        path.stroke()
    }
    

}
