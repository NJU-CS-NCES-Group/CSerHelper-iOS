//
//  showHomeworkItem.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/26.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import Foundation

class showHomeworkItem : NSObject {
    var homeworkName : String?
    var courseName : String?
    var information : String?
    var submitTime : Date?
    var grade : String? = nil
    init(courseName:String?,homeworkName:String?,information:String?,submitTime:Date?,grade:String?) {
        self.information = information
        self.courseName = courseName
        self.homeworkName = homeworkName
        self.submitTime = submitTime
        self.grade = grade
    }
    init(name:String?,submitTime:Date?) {
        self.homeworkName = name
        self.submitTime = submitTime
    }
}
