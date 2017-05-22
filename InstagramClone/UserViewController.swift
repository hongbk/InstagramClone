//
//  UserViewController.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/21/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    
    @IBOutlet weak var avatarUser: UIImageView!

    @IBOutlet weak var userNameLB: UILabel!
    
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
