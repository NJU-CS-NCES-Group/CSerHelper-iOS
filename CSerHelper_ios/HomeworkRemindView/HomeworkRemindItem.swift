//
//  HomeworkRemindItem.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/25.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import Foundation

class HomeworkRemindItem : NSObject{
    var courseName : String?
    var homeworkName : String?
    var remindTime : Date?
    var submitTime : Date?
    var isEnabled : Bool? = true
    init(courseName : String?, homeworkName: String?, remindTime:Date?, submitTime:Date?, _ isEnabled:Bool) {
        self.courseName = courseName
        self.homeworkName = homeworkName
        self.remindTime = remindTime
        self.submitTime = submitTime
        self.isEnabled = isEnabled
    }
}
