//
//  ModelStruct.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/14/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit
import SwiftyJSON

struct UserStruct {
    var userName: String?
    var email: String?
    var token: String?
    
    init(json: JSON) {
        self.userName = json["username"].string
        self.email = json["email"].string
        self.token = json["token"].string
    }
}

struct AuthorStruct {
    var userName: String?
    var image: String?
    var following: Bool?
    
    
    init(json: JSON) {
        self.userName = json["username"].string
        self.image = json["image"].string
        self.following = json["follwing"].bool
    }
}

struct PhotoStruct {
    var slug: String?
    var title: String?
    var description: String?
    var image: String?
    var createdAt: String?
    var updatedAt: String?
    var tagList: Array<Any>?
    var favorited: Bool?
    var favoritesCount: Int?
    var author: AuthorStruct?
    
    init() {}
    
    init(json: JSON, author: AuthorStruct) {
        self.slug = json["slug"].string
        self.title = json["title"].string
        self.description = json["description"].string
        self.image = json["image"].string
        self.createdAt = json["createdAt"].string
        self.updatedAt = json["updatedAt"].string
        self.tagList = json["tagList"].array
        self.favorited = json["favorited"].bool
        self.favoritesCount = json["favoritesCount"].int
        self.author = author
    }
}
