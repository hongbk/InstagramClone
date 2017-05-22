//
//  Utitlities.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/14/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

@objc class Utitlities: NSObject {

    static let shareManager = Utitlities()
    
    /**
     * @brief: Get object from NSUserDefault
     **/
    func getObject(key: String) -> AnyObject? {
        let object: AnyObject? = UserDefaults.standard.object(forKey: key) as AnyObject
        if let obj: AnyObject = object {
            return NSKeyedUnarchiver.unarchiveObject(with: obj as! Data) as AnyObject
        } else {
            return nil
        }
    }
    
    /**
     * @brief: Set object to NSUserDefault
     **/
    func setObject(object: AnyObject?, key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: !)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    
    class func isInternetAvailable() -> Bool{
        let reachability = Reachability.forInternetConnection()
        if reachability?.currentReachabilityStatus() != NetworkStatus.NotReachable {
            return true
        } else {
            print("Unable to create Reachability")
            return false
        }
    }
    
    
    // show alert
    class func showAlert(alert: String?, message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
// MARK: DateToString
    /**
     * @brief: Convert date to string
     **/
    
    class func dateStringToString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let stringReturn = dateFormatter.string(from: date!)
        return stringReturn
    }
}

// MARK: download image from link
extension UIImageView {
    func downloadedFrom(link link: String, contentMode  mode: UIViewContentMode) {
        guard
            let url = URL(string: link)
        else {return}
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
            let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else {
                print("Error when loading image")
                return }
            DispatchQueue.main.async() { () -> Void in
                print("Load image success")
                self.image = image
            }
        }.resume()
    }
}
