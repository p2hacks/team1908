//
//  File.swift
//  Connect
//
//  Created by b1018194 on 2/16/19.
//  Copyright © 2019 hajime ito. All rights reserved.
//

import BeerKit  //MultipeerConnectivityをもとに作られたライブラリ　通信処理をサポートする
import MultipeerConnectivity  //通信処理をサポートする　BeerKitでも参照されている

public class Connect {
    
    var isConnected: Bool?  //通信しているか？
    var messages: [account] = []  //jsonデータ、受け取り、読み込み用
    // 自分のプロフィールから渡されるパラメータ群
    var Myname: String = "a"   //名前
    var myID: String = "a"     //Id
    var Mymessage: String = "a"//一言
    var MystarType: Int = 0    //自分の惑星のタイプ
    
    init() {
        BeerKit.transceive(serviceType: "Connection")  //Connection識別子を持つ者同士で接続開始 クロージャの引数は自分のMypeerIDと相手のpeerID
        
        //実はこの中で、広報と招待が行われており、それぞれで指定したデータを送ることができる。
        //そのデータをもとにセッションを行うか判断できる　今回はnil
        
        BeerKit.onConnect { (myPeerId, peerId) in      //接続中の間（多分）
            DispatchQueue.main.async {
                self.isConnected = true                //通信しているのでtrue
            }
        }
        
        BeerKit.onDisconnect { (myPeerId, peerId) in  //切断中の間（多分）クロージャの引数は自分のMypeerIDと相手のpeerID
            DispatchQueue.main.async {
                self.isConnected = false              //通信していないのでfalse
            }
        }
        
        BeerKit.onEvent("message") { (peerId, data) in  //イベント中（明示的なデータの送受信）クロージャの引数は自分のpeerIDとdata
            guard let data = data,
                let message = try? JSONDecoder().decode(account.self, from: data) else { //デシリアライズ処理されたJsonファイルの中身が
                    return                                                               //ない時 return のみを返す
            }
            //追加
            self.messages.append(message)               //中身がある時、messages配列に追加
            
            DispatchQueue.main.async {
                //並列処理
            }
            
        }
        
    }
    
    
    func SessionSendInfo() {  //セッション相手全てに行われる処理　messageに保存された値が送信される
        
        let message = account(Name: Myname, id: myID, Message: Mymessage, StarType: MystarType)  //値をセット
        let data: Data = try! JSONEncoder().encode(message)   //シリアライズ処理
        BeerKit.sendEvent("message", data: data)  //イベント処理
        
        BeerKit.onDisconnect {(myPeerId, peerId) in
            //接続切れのアラート表示
            /*
             let alertController = UIAlertController(title: "接続エラー", message: "", preferredStyle: UIAlertController.Style.alert)
             let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil
             )
             alertController.addAction(cancelButton)
             present(alertController, animated: true, completion: nil)
             */
        }
        
    }
    
    func IndentifySendInfo(peerId: [MCPeerID]) {  //指定したpeerIdの相手のみに行われる処理　配列型より複数に送ることが可能（多分）
        
        let message = account(Name: Myname, id: myID, Message: Mymessage, StarType: MystarType)
        let data: Data = try! JSONEncoder().encode(message)
        BeerKit.sendEvent("message", data: data, toPeers: peerId)
        
        BeerKit.onDisconnect {(myPeerId, peerId) in
            //接続切れのアラート表示
            /*
             let alertController = UIAlertController(title: "接続エラー", message: "", preferredStyle: UIAlertController.Style.alert)
             let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil
             )
             alertController.addAction(cancelButton)
             present(alertController, animated: true, completion: nil)
             */
        }
        
    }
    
    func Cancel() {  //通信の切断、イベントの中断を行う
        BeerKit.removeAllEvents()
        BeerKit.stopTransceiving()
    }
    
    
    
}
