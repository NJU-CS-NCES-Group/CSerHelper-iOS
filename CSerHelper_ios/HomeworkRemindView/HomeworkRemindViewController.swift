//
//  HomeworkRemindViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class HomeworkRemindViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var homeworkRemindItems : [HomeworkRemindItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeworkRemindItems=getHomeworkRemindItems()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHomeworkRemindItems() -> [HomeworkRemindItem] {
        var ret:[HomeworkRemindItem] = []
        ret.append(HomeworkRemindItem(courseName: "移动互联", homeworkName: "大作业", remindTime: Date.init(), submitTime: Date.init(), true))
        ret.append(HomeworkRemindItem(courseName: "移动互联", homeworkName: "大作业", remindTime: Date.init(), submitTime: Date.init(), true))
        return ret
    }

    @IBAction func saveToHomeworkRemind(segue:UIStoryboardSegue){
        let data = segue.source as! AddHomeworkRemindViewController
        print("save!")
        homeworkRemindItems.append(HomeworkRemindItem(courseName: data.myCourses[data.courseNamePicker.selectedRow(inComponent: 0)].name, homeworkName: data.myHomework[data.courseNamePicker.selectedRow(inComponent: 1)].name, remindTime: data.timePicker.date, submitTime: data.myHomework[data.courseNamePicker.selectedRow(inComponent: 1)].submitTime, true))
        tableView.reloadData()
    }
    @IBAction func cancelToHomeworkRemind(segue:UIStoryboardSegue){
        
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

extension HomeworkRemindViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkRemindItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeworkRemindCell", for: indexPath) as? HomeworkRemindCell
        let item = homeworkRemindItems[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm:ss"
        cell?.courseNameLabel.text = item.courseName
        cell?.homeworkNameLabel.text = item.homeworkName
        cell?.remindTimeLabel.text = dateFormatter.string(from: item.remindTime!)
        cell?.submitTImeLabel.text = dateFormatter.string(from: item.submitTime!)
        cell?.isEnabledSwitch.isOn = item.isEnabled!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.homeworkRemindItems.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
}
