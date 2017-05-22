//
//  Defines.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/14/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

    
//MARK: CompletionClosure
typealias completionClosureInt = (Bool, Int, Any?) -> ()
typealias completionClosureLogin = (Bool, Int, Int, Any?) -> ()
typealias completionClosureString = (Bool, String, Any?) -> ()
let kLostConnectionConstant = -999
let kResultCodeSuccess = 1
let kResultCodeFail = 0

// MARK: - UserDatabasePlistfile
let kUserKey = "userkey"

// MARK: - Storyboard
let CPAppdelegate = UIApplication.shared.delegate as? AppDelegate

//MARK: NSUserDefaults key
let kSessionToken = "sessionToken"
let kSessionEmail = "sessionEmail"
let kCurrentUserId = "currentUserId"
