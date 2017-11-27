//
//  MyHomeworkCell.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/26.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class MyHomeworkCell: UITableViewCell {
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var homeworkName: UILabel!
    @IBOutlet weak var timeOrGrade: UILabel!
    @IBOutlet weak var homeworkInformation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
