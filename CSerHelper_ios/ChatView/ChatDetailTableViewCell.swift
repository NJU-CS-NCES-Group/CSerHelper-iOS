//
//  ChatDetailTableViewCell.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/12/3.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class ChatDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
