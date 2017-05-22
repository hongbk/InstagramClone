//
//  UserManager.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/15/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserManager: NSObject {
    
    static var filePath: String {
        let fileManager = FileManager.default
        
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        return (url!.appendingPathComponent("Data").path)
    }
    
    class func loadUserData() -> UserClass? {
        if let userData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UserClass {
            return userData
        } else {
            return nil
        }
    }
    
    class func saveUserData(userModel: UserClass?) {
        NSKeyedArchiver.archiveRootObject(userModel, toFile: filePath)
    }

    class func deleteSavedUserData() {
        do {
           try FileManager.default.removeItem(atPath: filePath)
        } catch let error as NSError{
            print("Error: \(error)")
        }
    }
    
    class func parseUserFromJson(json: JSON) -> UserClass{
        let user = UserClass()
        user.userName = json["userName"].string
        user.email = json["email"].string
        user.token = json["token"].string
        return user
    }
}
