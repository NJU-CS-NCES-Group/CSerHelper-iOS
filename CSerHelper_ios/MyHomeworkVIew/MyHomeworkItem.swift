//
//  MyHomeworkItem.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/25.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import Foundation

class MyHomeworkItem : NSObject {
    var name : String?
    var information : String?
    var submitTime : Date?
    var grade : String? = nil
    init(name:String?,information:String?,submitTime:Date?,grade:String?) {
        self.information = information
        self.name = name
        self.submitTime = submitTime
        self.grade = grade
    }
    init(name:String?,submitTime:Date?) {
        self.name = name
        self.submitTime = submitTime
    }
}
