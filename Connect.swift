//
//  File.swift
//  Connect
//
//  Created by b1018194 on 2/16/19.
//  Copyright © 2019 hajime ito. All rights reserved.
//

import BeerKit
import MultipeerConnectivity

public class Connect {
    
    var isConnected: Bool?
    var messages: [account] = []
    // アカウントからうけとる
    var Myname: String = "a"
    var myID: String = "a"
    var Mymessage: String = "a"
    var MystarType: Int = 0
    init() {
        BeerKit.transceive(serviceType: "Connection")
        
        BeerKit.onConnect { (myPeerId, peerId) in
            DispatchQueue.main.async {
                self.isConnected = true
            }
        }
        
        BeerKit.onDisconnect { (myPeerId, peerId) in
            DispatchQueue.main.async {
                self.isConnected = false
            }
        }
        
        BeerKit.onEvent("message") { (peerId, data) in
            guard let data = data,
                let message = try? JSONDecoder().decode(account.self, from: data) else {
                    return
            }
            //追加
            self.messages.append(message)
            
            DispatchQueue.main.async {
                
            }
            
        }
        
    }
    
    
    func SessionSendInfo() {
        
        let message = account(Name: Myname, id: myID, Message: Mymessage, StarType: MystarType)
        let data: Data = try! JSONEncoder().encode(message)
        BeerKit.sendEvent("message", data: data)
        
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
    
    func IndentifySendInfo(peerId: [MCPeerID]) {
        
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
    
    func Cancel() {
        BeerKit.removeAllEvents()
        BeerKit.stopTransceiving()
    }
    
    
    
}
