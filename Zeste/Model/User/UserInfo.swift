//
//  UserInfo.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/30.
//

struct UserInfo: Decodable {
    var nick : String
    var phone : String
    var points : Int
    
    var toDict : [String : Any] {
        let dict : [String : Any] = ["nick" : nick, "phone": phone, "points":points]
        return dict
    }
}
