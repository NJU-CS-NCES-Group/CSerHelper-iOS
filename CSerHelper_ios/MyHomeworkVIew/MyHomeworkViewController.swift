//
//  MyHomeworkViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class MyHomeworkViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var myCourses : [MyCourses] = []
    var comingHomeworkList : [showHomeworkItem] = []
    var finishHomeworkList : [showHomeworkItem] = []
    var showList:[showHomeworkItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyCourses()
        divideList()
        showList = comingHomeworkList
        tableView.rowHeight = 150
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMyCourses() -> Void {
//        var ret:[MyCourses] = []
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//        let hw1:[MyHomeworkItem] = [MyHomeworkItem.init(name: "作业一", information: "说明说明", submitTime: formatter.date(from: "2017-11-25 23:59:59"), grade: nil) ,MyHomeworkItem.init(name: "作业二", information: "说明说明", submitTime: formatter.date(from: "2017-11-30 23:59:59"), isGraded: false)]
//        let hw2:[MyHomeworkItem] = [MyHomeworkItem.init(name: "作业三", information: "说明说明", submitTime: formatter.date(from: "2017-11-25 23:59:59"), isGraded:false),MyHomeworkItem.init(name: "作业四", information: "说明说明", submitTime: formatter.date(from: "2017-11-30 23:59:59"), isGraded: false)]
//        ret.append(MyCourses.init(name: "移动互联", homeworks: hw1))
//        ret.append(MyCourses.init(name: "概率论", homeworks: hw2))
//        return ret
        let connectservice = ConnectService(id: "4", number: userNumber!, password: userPassword!)
        let semaphore = DispatchSemaphore(value: 0)
        connectservice.startService(){ (data, response, error) in
            if(error != nil){
                //提示网络错误
                print(error.debugDescription)
                let alertController = UIAlertController(title: "系统提示",
                                                        message: "网络错误", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alertController.addAction(confirmAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let decoder = JSONDecoder()
                if let json = try? decoder.decode([JSONcoder4].self, from: data!){
                    //print(json)
                    for item in json{
                        var hw : [MyHomeworkItem] = []
                        for hwitem in item.homework{
                            hw.append(MyHomeworkItem(name: hwitem.name, information: hwitem.intro, submitTime: Date.init(timeIntervalSince1970: TimeInterval.init(Int(hwitem.cutoffdate)!)), grade: hwitem.grade))
                        }
                        self.myCourses.append(MyCourses(name: item.classname, homeworks: hw))
                    }
                }
                else{
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "系统提示",
                                                                message: "解码错误", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertController.addAction(confirmAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            semaphore.signal()
        }
        semaphore.wait()
    }

    func divideList() {
        for courseitem in myCourses {
            for homeworkitem in courseitem.homeworks{
                if homeworkitem.submitTime! > Date() {
                    comingHomeworkList.append(showHomeworkItem(courseName: courseitem.name, homeworkName: homeworkitem.name, information: homeworkitem.information, submitTime: homeworkitem.submitTime, grade: homeworkitem.grade))
                }
                else{
                    finishHomeworkList.append(showHomeworkItem(courseName: courseitem.name, homeworkName: homeworkitem.name, information: homeworkitem.information, submitTime: homeworkitem.submitTime, grade: homeworkitem.grade))
                }
            }
        }
    }
    
    @IBAction func comingTapped(){
        showList = comingHomeworkList
        tableView.reloadData()
    }
    
    @IBAction func finishTapped(){
        showList = finishHomeworkList
        tableView.reloadData()
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

extension MyHomeworkViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyHomeworkCell", for: indexPath) as? MyHomeworkCell
        let item = showList[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        cell?.courseName.text = item.courseName
        cell?.homeworkName.text = item.homeworkName
        cell?.homeworkInformation.text = item.information
        if item.submitTime! > Date() {
            cell?.timeOrGrade.text = formatter.string(from: item.submitTime!)
        }
        else {
            if item.grade != nil{
                cell?.timeOrGrade.text = "已评分:" + item.grade!
            }
            else{
                cell?.timeOrGrade.text = "未评分"
            }
        }
        return cell!
    }
    
    
}
