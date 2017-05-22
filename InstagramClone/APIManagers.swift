//
//  APIManagers.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/14/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit
import SwiftyJSON
import PKHUD
import Alamofire

class APIManagers: NSObject {
    
    struct APIEndPoint {
        static let kTokenUser = ""
        static let kBaseURL = "https://iossimple-instagram.herokuapp.com/"
        static let kBaseURLApi = "https://iossimple-instagram.herokuapp.com/api/"
        static let kLoginURL = "user/login"
        static let kCurrentUser = "user"
        static let kProfile = "profiles/"
        static let kPhotos = "photos"
        static let kFeedPhotos = "photos/feed"
    }
    
    static let shareManager = APIManagers()
    
    func showLostConnection() {
        HUD.flash(.labeledError(title: "You are no Internet", subtitle: nil), delay: 1)
    }
    
    func checkNetworkAvailable(completeHandler: completionClosureInt) {
        if (!Utitlities.isInternetAvailable()) {
            self.showLostConnection()
            completeHandler(false, kLostConnectionConstant, nil)
            return
        }
    }
    
    func requestURL(endPoint: String, params: [String : Any]?, method: HTTPMethod,completeHandler: @escaping completionClosureInt) -> () {
        
        // check network
        self.checkNetworkAvailable(completeHandler: completeHandler)
        let apiURL = APIEndPoint.kBaseURLApi + endPoint
        let currentUser = UserManager.loadUserData()
        
        let headers = [
            "Authorization" : "Token " + (currentUser?.token)!
        ] 
        
        
        Alamofire.request(apiURL, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .response { response in
                if (response.error == nil) {
                    let json = JSON(response.data)
                    completeHandler(true, 1, json)
                } else {
                    completeHandler(false, -1, response.error)
                }
        }
        
    }
    
    func getListPhotos( completeHandler: @escaping completionClosureInt) {
        let url = APIEndPoint.kPhotos
        self.requestURL(endPoint: url, params: nil, method: HTTPMethod.get, completeHandler: completeHandler)
    }

    
    func uploadPhoto(endPoint: String, imageData: URL, title: String, description: String?, tagList: Array<Any>?,
                     completeHandler: @escaping completionClosureInt) -> () {
        
        self.checkNetworkAvailable(completeHandler: completeHandler)
        let apiURL = APIManagers.APIEndPoint.kBaseURLApi + endPoint
        let currentUser = UserManager.loadUserData()
        let headers = [
            "Authorization" : "Token " + (currentUser?.token)!
            ] 
        
        let parameters = [
            "title" : title,
            "description" : description ?? "",
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            multipartFormData.append("".data(using: String.Encoding.utf8)!, withName: "tagList")
        }, to: apiURL, method : .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                
                upload.responseJSON { response in
                    //print(response)
                    let json = JSON(response.data)
                    completeHandler(true, 1, json)
                }
                
            case .failure(let encodingError):
                //print(encodingError)
                completeHandler(false, -1, encodingError)
                break
            }
        }
    }
}
