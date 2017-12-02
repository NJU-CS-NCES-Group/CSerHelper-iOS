//
//  LoginViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/12/2.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginBtn(){
        /**登陆验证成功**/
        //checkLogin(usernumber: numberText.text, password: passwordText.text)
        
        let connectservice = ConnectService(id:"0",number:numberText.text!,password:passwordText.text!)
        connectservice.startService(){ (data, response, error) in
            //5.解析数据
            if(error != nil){
                print(error.debugDescription)
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "系统提示",
                                                            message: "网络错误", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                    alertController.addAction(confirmAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            else{
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(JSONcoder0.self, from: data!){
                    print(json)
                    let sign = json.sign
                    if sign == 1 {
                        DispatchQueue.main.async {
                            userNumber = self.numberText.text;
                            userPassword = self.passwordText.text;
                            self.performSegue(withIdentifier: "Login", sender: self)
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "系统提示",
                                                                    message: "密码错误", preferredStyle: .alert)
                            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                            alertController.addAction(confirmAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "系统提示",
                                                                message: "解码错误", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertController.addAction(confirmAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
        
//        let str = desHost + "id=0&idnumber=\(numberText.text!)&password=\(passwordText.text!)"
//        let url: NSURL = NSURL(string:str)!
//        //2.获得会话对象
//        let session: URLSession = URLSession.shared
//
//        //3.根据会话对象创建一个Task(发送请求）
//        /*
//         第一个参数：请求路径
//         第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
//         data：响应体信息（期望的数据）
//         response：响应头信息，主要是对服务器端的描述
//         error：错误信息，如果请求失败，则error有值
//         注意：
//         1）该方法内部会自动将请求路径包装成一个请求对象，该请求对象默认包含了请求头信息和请求方法（GET）
//         2）如果要发送的是POST请求，则不能使用该方法
//         */
//        let dataTask: URLSessionDataTask = session.dataTask(with: url as URL){ (data, response, error) in
//            //5.解析数据
//            if(error != nil){
//                print(error.debugDescription)
//            }
//            else{
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]{
//                    print(json)
//                    let sign = json["sign"] as! Int
//                    if sign == 1 {
//                        DispatchQueue.main.async {
//                            userNumber = self.numberText.text;
//                            userPassword = self.passwordText.text;
//                            self.performSegue(withIdentifier: "Login", sender: self)
//                        }
//                    }
//                    else{
//                        DispatchQueue.main.async {
//                            let alertController = UIAlertController(title: "系统提示",
//                                                                    message: "密码错误", preferredStyle: .alert)
//                            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
//                            alertController.addAction(confirmAction)
//                            self.present(alertController, animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//        dataTask.resume()
//    }
}
