//
//  ViewController.swift
//  ScrollView
//
//  Created by Tobioka on 2017/10/19.
//  Copyright © 2017年 tnantoka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// [marker1]
    @IBOutlet weak var scrollView: UIScrollView!
    /// [marker1]

    /// [marker2]
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: 800.0, height: 568)
        scrollView.frame.size = CGSize(width: 320, height: 568)
        scrollView.contentOffset = CGPoint(x: 240, y: 0)
        
        // ボタンの生成
        let button = UIButton(type: UIButtonType.system)
        // 位置とサイズの指定
        button.frame = CGRect(x: 100, y: 0, width: 300, height: 40)
        // ボタンの位置を中心に設定する
        button.center = self.view.center
        // ボタンのタイトルの設定
        button.setTitle("ボタン", for: .normal)
        // 配色の設定
        button.backgroundColor = UIColor.gray
        // ボタンの文字色の設定
        button.setTitleColor(UIColor.white, for: .normal)
        // ボタンの配置
        self.view.addSubview(button)
    }
    /// [marker2]

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
      
    


}

