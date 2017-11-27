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
        myCourses = getMyCourses()
        divideList()
        showList = comingHomeworkList
        tableView.rowHeight = 100
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMyCourses() -> [MyCourses] {
        var ret:[MyCourses] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let hw1:[MyHomeworkItem] = [MyHomeworkItem.init(name: "作业一", information: "说明说明", submitTime: formatter.date(from: "2017-11-25 23:59:59"), isGraded: true) ,MyHomeworkItem.init(name: "作业二", information: "说明说明", submitTime: formatter.date(from: "2017-11-30 23:59:59"), isGraded: false)]
        let hw2:[MyHomeworkItem] = [MyHomeworkItem.init(name: "作业三", information: "说明说明", submitTime: formatter.date(from: "2017-11-25 23:59:59"), isGraded:false),MyHomeworkItem.init(name: "作业四", information: "说明说明", submitTime: formatter.date(from: "2017-11-30 23:59:59"), isGraded: false)]
        ret.append(MyCourses.init(name: "移动互联", homeworks: hw1))
        ret.append(MyCourses.init(name: "概率论", homeworks: hw2))
        return ret
    }

    func divideList() {
        for courseitem in myCourses {
            for homeworkitem in courseitem.homeworks{
                if homeworkitem.submitTime! > Date() {
                    comingHomeworkList.append(showHomeworkItem(courseName: courseitem.name, homeworkName: homeworkitem.name, information: homeworkitem.information, submitTime: homeworkitem.submitTime, isGraded: homeworkitem.isGraded))
                }
                else{
                    finishHomeworkList.append(showHomeworkItem(courseName: courseitem.name, homeworkName: homeworkitem.name, information: homeworkitem.information, submitTime: homeworkitem.submitTime, isGraded: homeworkitem.isGraded))
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
            if item.isGraded {
                cell?.timeOrGrade.text = "已评分"
            }
            else{
                cell?.timeOrGrade.text = "未评分"
            }
        }
        return cell!
    }
    
    
}
