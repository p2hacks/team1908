///Users/haruka/Desktop/Xcode/Timer03/Timer03/ViewController.swift
//  ViewController.swift
//  Timer03
//
//  Created by 藤内悠 on 2019/02/11.
//  Copyright © 2019 Jonny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    private var timer = Timer()//Timerというクラスを用いた　https://developer.apple.com/documentation/foundation/timer
    //private var count = 0.0//初期状態
    open var count = 0.0//初期状態
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func countSecond() {//秒数カウント
        count += 0.1
       // FriendShip += 0.1
        timerLabel.text = String(format: "%.1f", count)
        
    }
    
    @IBAction func StartTimer(_ sender: Any) {//スタートボタン
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.countSecond), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func StopTimer(_ sender: Any) {//カウントストップ
        if timer.isValid {
            timer.invalidate()
        }
    }
    
    @IBAction func ResetTimer(_ sender: Any) {//カウントリセト
        timer.invalidate()
        count = 0.0
        timerLabel.text = String(format: "%.1f", count)
    }
    
    
}

