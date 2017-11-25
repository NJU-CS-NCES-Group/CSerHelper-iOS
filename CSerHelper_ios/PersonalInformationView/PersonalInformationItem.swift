//
//  PersonalInformationItem.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class PersonalInformationItem: NSObject {
    
    var number:String?
    var name:String?
    var email:String?
    var phone:String?
    
    init(number:String?,name:String?,email:String?,phone:String?) {
        self.number=number
        self.name=name
        self.email=email
        self.phone=phone
    }
    override init() {
        
    }
}
