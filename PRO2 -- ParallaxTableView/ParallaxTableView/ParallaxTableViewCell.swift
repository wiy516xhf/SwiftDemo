//
//  ParallaxTableViewCell.swift
//  ParallaxTableView
//
//  Created by hongfei xie on 16/2/21.
//  Copyright © 2016年 hongfei xie. All rights reserved.
//

import UIKit

class ParallaxTableViewCell: UITableViewCell {

    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var topCon: NSLayoutConstraint!
    @IBOutlet weak var btmCon: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clipsToBounds = true
        bgImgView.clipsToBounds = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

