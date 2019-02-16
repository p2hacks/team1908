//
//  File.swift
//  Connect
//
//  Created by b1018194 on 2019/02/16.
//  Copyright © 2019年 hajime ito. All rights reserved.
//

import Foundation

class account: Codable {
    var name: String = ""
    var ID: [Int] = []
    var message: String = ""
    var starType: Int = 0
    
    init(Name: String, id: [Int], Message: String, StarType: Int) {
        name = Name
        ID = id
        message = Message
        starType = StarType
    }
    
}

