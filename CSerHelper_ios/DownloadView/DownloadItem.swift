//
//  DownloadItem.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/22.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class DownloadItem: NSObject {
    
    var name:String?
    var fileUrl:String?
    var isDownloaded:Bool = false
    var isDownloading:Bool = false
    
    init(name:String? , fileUrl:String?) {
        self.name = name
        self.fileUrl = fileUrl
    }
    
}
