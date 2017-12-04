//
//  ChatViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subjectButton: UIButton!
    
    var items:[[JSONcoder6]] = []
    var map:[JSONcoder5] = []
    
    func getMap() -> Void {
        let connectservice = ConnectService(id:"5",number:userNumber!,password:userPassword!)
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
                if let json = try? decoder.decode([JSONcoder5].self, from: data!){
                    //print(json)
                    self.map = json
                    DispatchQueue.main.async {
                        self.subjectButton.setTitle(self.map[0].fullname, for: .normal)
                        self.getItems()
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
    
    func getItems() -> Void {
        var classid:String? = nil
        for i in map{
            if i.fullname == subjectButton.title(for: .normal){
                classid = i.classid
            }
        }
        let connectservice = ConnectService(id: "6", number: userNumber!, password: userPassword!, classid: classid)
        connectservice.startService6(){ (data, response, error) in
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
                if let json = try? decoder.decode([[JSONcoder6]].self, from: data!){
                    //print(json)
                    self.items = json
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func classButtonTapped() {
        let picker = UIPickerView()
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        picker.dataSource = self
        picker.delegate = self
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .default){
            (alertAction)->Void in
            self.subjectButton.setTitle(self.map[picker.selectedRow(inComponent: 0)].fullname, for: .normal)
            self.getItems()
        })
        alert.view.addSubview(picker)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as! ChatDetailTableViewController
        controller.items = (sender as? [JSONcoder6])!
        //print(controller.items)
    }

}

extension ChatViewController :UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return map.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return map[row].fullname
    }
    
}

extension ChatViewController : UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowChatDetailView", sender: items[indexPath.row])
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatViewCell", for: indexPath) as? ChatTableViewCell
        let item = items[indexPath.row][0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        cell?.nameLabel.text = item.name
        cell?.SubjectLabel.text = item.subject
        cell?.messageLabel.text = item.message
        cell?.timeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: Int(item.created)!)!))
        return cell!
    }
}
