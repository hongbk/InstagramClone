//
//  PhotoCell.swift
//  InstagramClone
//
//  Created by Nguyễn Hồng on 5/14/17.
//  Copyright © 2017 iossimple. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var numberLikeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeBtWasTapped(_ sender: UIButton) {
        
    }

    @IBAction func commentBtWasTapped(_ sender: UIButton) {
        
    }
    
}
