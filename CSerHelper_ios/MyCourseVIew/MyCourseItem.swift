//
//  MyCourseItem.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/25.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import Foundation
class MyCourseItem : NSObject {
    var oddOrEven : Int = 0  //0表示不限制，1表示单周，2表示双周
    var classroom : String?
    var weekly : Int
    var startTime : Int
    var endTime : Int
    init(oddOrEven:Int,classroom:String?,weekly:Int,startTime:Int,endTime:Int) {
        self.oddOrEven = oddOrEven
        self.classroom = classroom
        self.weekly = weekly
        self.startTime = startTime
        self.endTime = endTime
    }
    
}
