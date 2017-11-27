//
//  MyCourses.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/26.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import Foundation

class MyCourses: NSObject {
    var name : String
    var startWeek:Int = 1
    var endWeek:Int = 20
    var courseInformations : [MyCourseItem] = []
    var teacherName : [String] = []
    var homeworks : [MyHomeworkItem]
    init(name:String,startWeek:Int,endWeek:Int,courseInformations:[MyCourseItem],teacherName:[String],homeworks:[MyHomeworkItem]) {
        self.name=name
        self.startWeek = startWeek
        self.endWeek = endWeek
        self.courseInformations = courseInformations
        self.teacherName = teacherName
        self.homeworks = homeworks
    }
    init(name:String,homeworks:[MyHomeworkItem]) {
        self.name = name
        self.homeworks = homeworks
    }
}
