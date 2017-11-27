//
//  AddHomeworkRemindViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/26.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class AddHomeworkRemindViewController: UIViewController {
    @IBOutlet weak var courseNamePicker: UIPickerView!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var myCourses:[MyCourses] = []
    var myHomework:[MyHomeworkItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCourses = getMyCourses()
        myHomework = myCourses[0].homeworks
        timePicker.minimumDate = Date()
        timePicker.maximumDate = myHomework[0].submitTime
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
        let hw1:[MyHomeworkItem] = [MyHomeworkItem.init(name: "作业一", submitTime: formatter.date(from: "2017-11-28 23:59:59")),MyHomeworkItem.init(name: "作业二", submitTime: formatter.date(from: "2017-11-30 23:59:59"))]
        let hw2:[MyHomeworkItem] = [MyHomeworkItem.init(name: "作业三", submitTime: formatter.date(from: "2017-11-28 23:59:59")),MyHomeworkItem.init(name: "作业四", submitTime: formatter.date(from: "2017-11-30 23:59:59"))]
        ret.append(MyCourses.init(name: "移动互联", homeworks: hw1))
        ret.append(MyCourses.init(name: "概率论", homeworks: hw2))
        return ret
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

extension AddHomeworkRemindViewController : UIPickerViewDataSource , UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return myCourses.count
        }
        else {
            return myHomework.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if 0 == component {
            return myCourses[row].name
        }
        else {
            return myHomework[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if 0 == component {
            myHomework = myCourses[row].homeworks
            courseNamePicker.reloadComponent(1)
            courseNamePicker.selectRow(0, inComponent: 1, animated: true)
        }
        else{
            timePicker.minimumDate = Date()
            timePicker.maximumDate = myHomework[row].submitTime
        }
    }
}
