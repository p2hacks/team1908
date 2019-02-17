//
//  ViewController.swift
//  ScrollView
//
//  Created by Tobioka on 2017/10/19.
//  Copyright © 2017年 tnantoka. All rights reserved.
//

import UIKit
import BeerKit
import MultipeerConnectivity

class ViewController: UIViewController {

    /// [marker1]
    @IBOutlet weak var scrollView: UIScrollView!
    /// [marker1]

    /// [marker2]
    override func viewDidLoad() {
        super.viewDidLoad()
     Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
        scrollView.contentSize = CGSize(width: 800.0, height: 568)
        scrollView.frame.size = CGSize(width: 320, height: 568)
        scrollView.contentOffset = CGPoint(x: 240, y: 0)
        
        // ボタンの生成
        let button = UIButton(type: UIButtonType.system)
        // 位置とサイズの指定
        button.frame = CGRect(x: 100, y: 2000, width: 300, height: 40)
        // ボタンの位置を中心に設定する
        //button.center = self.view.center
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
    
 var messages: [account] = []
 var PeerIdArray: [[MCPeerID]] = []
    
    var Myname: String = "nil"
    var Myid: String = "nil"
    var Mymessage: String = "nil"
    var MystarType: Int = 0
    var Myfamilier: Int = 0
    
    @objc func timerUpdate() {
        BeerKit.onConnect { (myPeerId, peerId) in
            //接続時に読み込む処理
            DispatchQueue.main.async {
                let message = account(Name: self.Myname, id: self.Myid, Message: self.Mymessage, StarType: self.MystarType, familier: self.Myfamilier)
                let data:Data = try! JSONEncoder().encode(message)
                BeerKit.sendEvent("message", data:data)
            }
        }
        
        BeerKit.onEvent("message") { (peerId, data) in
          guard let data = data,
            let message = try? JSONDecoder().decode(account.self, from: data) else {
                return
            }
            self.messages.append(message)
            self.PeerIdArray.append([peerId])
            
            DispatchQueue.main.sync {
                //messages,PeerID,MYINFOg群を友達表示画面へ渡す
                
                
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let viewController = segue.destination as!  FriendScreenViewController
        
        viewController.FriendArray = messages
        viewController.PeerIdArray = PeerIdArray
        viewController.Myname = Myname
        viewController.Myid = Myid
        viewController.Mymessage = Mymessage
        viewController.MystarType = MystarType
        viewController.Myfamilier = Myfamilier
    }
      
    


}

