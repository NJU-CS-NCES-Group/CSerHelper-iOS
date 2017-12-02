//
//  ConnectHost.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/12/2.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import Foundation
class ConnectService: NSObject {
    var id:String
    var number:String
    var password:String
    init(id:String,number:String,password:String) {
        self.id = id
        self.number = number
        self.password = password
    }
    func startService(completionHandler:@escaping (_ data:Data?,_ response:URLResponse?,_ error:Error?) -> Void){
        
        let str = desHost + "id=\(id)&idnumber=\(number)&password=\(password)"
        let url: NSURL = NSURL(string:str)!
        //2.获得会话对象
        let session: URLSession = URLSession.shared
        
        //3.根据会话对象创建一个Task(发送请求）
        /*
         第一个参数：请求路径
         第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
         data：响应体信息（期望的数据）
         response：响应头信息，主要是对服务器端的描述
         error：错误信息，如果请求失败，则error有值
         注意：
         1）该方法内部会自动将请求路径包装成一个请求对象，该请求对象默认包含了请求头信息和请求方法（GET）
         2）如果要发送的是POST请求，则不能使用该方法
         */
        let dataTask: URLSessionDataTask = session.dataTask(with: url as URL,completionHandler:completionHandler)
        dataTask.resume()
    }
}

struct JSONcoder0 : Codable {
    let id:String
    let username:String
    let email:String
    let firstname:String
    let phone1:String
    let sign:Int
    let department:String
    let firstaccess:String
    let lastaccess:String
    let lastlogin:String
    let lastip:String
}

struct JSONcoder2 : Codable {
    let fullname:String
    struct Time : Codable {
        let weektype:String
        let weekday:String
        let classtime:String
        let fullname:String
        let grade:String
        let semester:String
    }
    let time:[Time]
    let teachers:[String?]
}
