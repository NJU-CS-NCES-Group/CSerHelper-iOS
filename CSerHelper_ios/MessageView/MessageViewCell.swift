//
//  MessageViewCell.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
