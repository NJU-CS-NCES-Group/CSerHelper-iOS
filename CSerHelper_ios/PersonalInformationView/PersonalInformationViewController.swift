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
        localInformation=getInformation()
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
    func getInformation() -> PersonalInformationItem {
        let ret=PersonalInformationItem(number:"1234567",name:"计小科",email:"12345678",phone:"123456")
        return ret
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
