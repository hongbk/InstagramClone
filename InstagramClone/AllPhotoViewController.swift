//
//  MainViewController.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/14/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit
import SwiftyJSON
import PKHUD

class AllPhotoViewController: UIViewController {
    
    var listPhotos = [PhotoStruct]()
    
    var numberPhotos = 0
    
    @IBOutlet var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTable.delegate = self
        self.myTable.dataSource = self
        self.myTable.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        if (Utitlities.isInternetAvailable()) {
            HUD.show(.labeledProgress(title: "Loading..", subtitle: nil))
            self.loadListPhotos()
        } else {
            Utitlities.showAlert(alert: "Alert", message: "No internet", vc: self)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension AllPhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = myTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PhotoCell

        cell.titleLB.text = listPhotos[indexPath.row].title
        
        if let imageUrl = listPhotos[indexPath.row].image {
            let url = APIManagers.APIEndPoint.kBaseURL + imageUrl
            print(url)
            cell.imageView!.downloadedFrom(link: url, contentMode: .scaleAspectFit)
        }
        
        cell.descriptionLB.text = listPhotos[indexPath.row].description
        
        cell.numberLikeLabel.text = "\(listPhotos[indexPath.row].favoritesCount!)" + "like"
//        if (self.numberPhotos == indexPath.row) {
//            HUD.hide()
//        }
        return cell
    }
}

extension AllPhotoViewController {
    
    fileprivate func loadListPhotos() {
        APIManagers.shareManager.getListPhotos { [unowned self](result, resultCode, json) in
            if (result) {
                let jsonData = json as! JSON
                let listPhotos = jsonData["photos"]
                self.numberPhotos = jsonData["photosCount"].int!
                var tempListPhotos = [PhotoStruct]()
                for (_, photoData) in listPhotos {
                    let author = AuthorStruct(json: JSON(photoData["author"].dictionaryObject))
                    let photo = PhotoStruct(json: photoData, author: author)
                    tempListPhotos.append(photo)
                }
                self.listPhotos = tempListPhotos
                self.myTable.reloadData()
                HUD.hide()
            }
        }
    }
}

