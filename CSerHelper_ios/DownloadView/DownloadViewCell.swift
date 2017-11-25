//
//  DownloadViewCell.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/22.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

protocol DownloadViewDelegate{
    func downloadTapped(_ cell: DownloadViewCell)
    func openTapped(_ cell:DownloadViewCell)
}

class DownloadViewCell: UITableViewCell {
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var fileName: UILabel!
    
    var delegate:DownloadViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func downloadTapped(_ sender: AnyObject) {
        delegate?.downloadTapped(self)
    }
    @IBAction func openTapped(_ sender: AnyObject) {
        delegate?.openTapped(self)
    }
}
