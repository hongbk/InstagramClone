//
//  ViewController.swift
//  InstagramClone
//
//  Created by Viet Nguyen Tran on 5/10/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = st.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginVC, animated: true, completion: nil)
    }


}

