//
//  StarDraw.swift
//  ScrollView
//
//  Created by 藤内悠 on 2019/02/16.
//  Copyright © 2019 tnantoka. All rights reserved.
//

import UIKit
//アメコミ調

class StarDraw: UIView {

    let Star_x = Int.random(in: 0..<40)
    let screenWidth: CGFloat = UIScreen.main.bounds.width      //画面の幅
    let screenHeight: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    
    override func draw(_ rect: CGRect) {
        
       // oval1()
        oval4()
        oval3()
        oval2()
        oval1()
    }
    
    /*func oval*() {//
        /// [marker*]
        let path = UIBezierPath(
            ovalIn: CGRect(x: 400 - x, y: 279 - y - 50, width: 2x, height: 2y)
        )
        UIColor.magenta.setFill()
        path.fill()
        /// [marker*]
    }*/
    
    func oval1() {//自身の恒星
        /// [marker1]
        let path = UIBezierPath(
            ovalIn: CGRect(x: 400 - 50, y: 279 - 50 - 50 - 10, width: 100.0, height: 100.0)
        )
        UIColor.yellow.setFill()
        path.fill()
        /// [marker1]
    }
    
   func oval2() {
        /// [marker2]
        let path = UIBezierPath(
            ovalIn: CGRect(x: 400 - 150, y: 279 - 75 - 50 , width: 300, height:150 )
        )
        UIColor.blue.setFill()
        path.fill()
        /// [marker2]
    }
    
    func oval3() {
        /// [marker2]
        let path = UIBezierPath(
            ovalIn: CGRect(x: 400 - 300, y: 279 - 150 - 30, width: 600, height:300 )
        )
        UIColor.black.setFill()
        path.fill()
        /// [marker2]
    }
    
    func oval4() {
        /// [marker2]
        let path = UIBezierPath(
            ovalIn: CGRect(x: 400 - 400, y: 279 - 200 - 10, width: 800, height:400 )
        )
        UIColor.brown.setFill()
        path.fill()
        /// [marker2]
    }
    
    
 
}

