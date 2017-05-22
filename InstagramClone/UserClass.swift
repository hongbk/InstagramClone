//
//  UserClass.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/14/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserClass: NSObject, NSCoding {
    var userName: String?
    var email: String?
    var token: String?
    
    override init() {
        
    }
    
    convenience init(userName: String?, email: String?, token: String?) {
        self.init()
        self.userName = userName
        self.email = email
        self.token = token
    }
    
    convenience init(json: JSON) {
        self.init()
        self.userName = json["username"].string
        self.email = json["email"].string
        self.token = json["token"].string
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.userName = aDecoder.decodeObject(forKey: "username") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.token = aDecoder.decodeObject(forKey: "token") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: "username")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(token, forKey: "token")
    }
}
