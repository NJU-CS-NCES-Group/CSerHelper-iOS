//
//  PersonalInformationViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class PersonalInformationViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var studentNumberLabel: UILabel!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var localInformation = PersonalInformationItem()
    
    
    override func viewDidLoad() {
        getInformation()
        nameLabel.text=localInformation.name
        studentNumberLabel.text=localInformation.number
        emailText.text=localInformation.email
        phoneText.text=localInformation.phone
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getInformation(){
        let str = desHost + "id=0&idnumber=\(userNumber!)&password=\(userPassword!)"
        let url: NSURL = NSURL(string:str)!
        let session: URLSession = URLSession.shared
        let semaphore = DispatchSemaphore(value: 0)
        let dataTask: URLSessionDataTask = session.dataTask(with: url as URL){ (data, response, error) in
            if(error != nil){
                print(error.debugDescription)
                let alertController = UIAlertController(title: "系统提示",
                                                        message: "网络错误", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alertController.addAction(confirmAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]{
                    print(json)
                    //let sign = json["sign"] as! Int
                    self.localInformation = PersonalInformationItem(number:userNumber!,name:(json["firstname"] as! String),email:json["email"] as? String,phone:json["phone1"] as? String)
                    semaphore.signal()
                }
            }
        }
        dataTask.resume()
        semaphore.wait()
        return
    }
    @IBAction func pressEdit(){
        self.navigationItem.rightBarButtonItem=UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(pressSave))
        phoneText.isEnabled=true
        emailText.isEnabled=true
    }
    
    @objc func pressSave(){
        self.navigationItem.rightBarButtonItem=UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(pressEdit))
        phoneText.isEnabled=false
        emailText.isEnabled=false
    }
    
    func saveInformaition() {
        localInformation.email=emailText.text;
        localInformation.phone=phoneText.text;
        //TODO: 上传数据至服务器
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
