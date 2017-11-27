//
//  HomeworkRemindCell.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/26.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class HomeworkRemindCell: UITableViewCell {
    @IBOutlet weak var remindTimeLabel: UILabel!
    @IBOutlet weak var homeworkNameLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var submitTImeLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
