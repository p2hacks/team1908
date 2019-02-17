//
//  FriendScreenViewController.swift
//  ScrollView
//
//  Created by 藤内悠 on 2019/02/17.
//  Copyright © 2019 tnantoka. All rights reserved.
//

import UIKit
import BeerKit
import MultipeerConnectivity

class FriendScreenViewController: UIViewController {

    var FriendArray: [account] = []
    var PeerIdArray: [[MCPeerID]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInsection section: Int) -> Int {
        return FriendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.detailTextLabel?.text = FriendArray[indexPath.row].message
        cell.textLabel?.text = FriendArray[indexPath.row].name
        return cell
    }
    
    var Myname: String = "nil"
    var Myid: String = "nil"
    var Mymessage: String = "nil"
    var MystarType: Int = 0
    var Myfamilier: Int = 0
    
    func tableView(_tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = account(Name: self.Myname, id: self.Myid, Message: self.Mymessage, StarType: self.MystarType, familier: self.Myfamilier)
        let data = try! JSONEncoder().encode(message)
        BeerKit.sendEvent("message", data: data, toPeers: PeerIdArray[indexPath.row])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}
