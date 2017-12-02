//
//  MyCourseViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class MyCourseViewController: UIViewController {
    let startX : CGFloat = 0
    let startY : CGFloat = 0
    let unitWidth : CGFloat = (UIScreen.main.bounds.width - 30) / 5
    let unitHeight : CGFloat = (UIScreen.main.bounds.height - 113-80) / 11
    let cornerRadius : CGFloat = 20
    
    
    @IBOutlet weak var classView: UIView!
    @IBOutlet weak var addClass: UIButton!
    @IBOutlet weak var currentWeek: UILabel!
    @IBOutlet weak var addWeek: UIButton!
    @IBOutlet weak var subWeek: UIButton!
    var myCourses:[MyCourses] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        myCourses = getMyCourses()
        reloadClassView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addCourses(course:MyCourses) {
        let cwk = Int(currentWeek.text!)
        let color = UIColor.orange.cgColor
        
        for item in course.courseInformations {
            if cwk! <= course.endWeek && cwk! >= course.startWeek{
                if item.oddOrEven == 0{
                    addItem(name: course.name, inform: item, color: color)
                }
                else if item.oddOrEven == 1 && cwk! % 2 == 1{
                    addItem(name: course.name, inform: item, color: color)
                }
                else if item.oddOrEven == 2 && cwk! % 2 == 0{
                    addItem(name: course.name, inform: item, color: color)
                }
            }
        }
        
    }
    
    func addItem(name:String?,inform:MyCourseItem,color:CGColor){
        let label = UILabel(frame: CGRect(x: startX + unitWidth * (CGFloat(inform.weekly) - 1), y: startY + unitHeight * (CGFloat(inform.startTime) - 1), width: unitWidth, height: unitHeight * (CGFloat(inform.endTime) - CGFloat(inform.startTime) + 1)))
        label.numberOfLines = 6
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.backgroundColor = color
        label.layer.cornerRadius = cornerRadius
        label.text = name! + "@" + inform.classroom!
        classView.addSubview(label)
    }
    
    func reloadClassView() {
        let subviews = classView.subviews
        for view in subviews {
            view.removeFromSuperview()
        }
        for course in myCourses {
            addCourses(course: course)
        }
    }
    //只显示大二上学期 semster = 10
    func getMyCourses() -> [MyCourses] {
        let courseItem1 = MyCourseItem(oddOrEven: 0, classroom: "逸夫楼", weekly: 1, startTime: 1, endTime: 2)
        let courseItem2 = MyCourseItem(oddOrEven: 1, classroom: "仙一", weekly: 3, startTime: 3, endTime: 4)
        let courseItem3 = MyCourseItem(oddOrEven: 2, classroom: "仙一", weekly: 3, startTime: 3, endTime: 4)
        let courseItem4 = MyCourseItem(oddOrEven: 0, classroom: "仙二", weekly: 5, startTime: 9, endTime: 11)
        let course1 = MyCourses(name: "概率论", startWeek: 1, endWeek: 18, courseInformations: [courseItem1,courseItem2], teacherName: ["芙神"], homeworks: [])
        let course2 = MyCourses(name: "移动互联", startWeek: 1, endWeek: 18, courseInformations: [courseItem3,courseItem4], teacherName: ["曹春"], homeworks: [])
        let ret = [course1,course2]
        
        
        let connectService = ConnectService(id: "2", number: userNumber!, password: userPassword!)
        connectService.startService(){(data, response, error) in
            //print(data!)
            if(error != nil){
                //提示网络错误
                print(error.debugDescription)
                let alertController = UIAlertController(title: "系统提示",message: "网络错误", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alertController.addAction(confirmAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let decoder = JSONDecoder()
                if let json = try? decoder.decode([JSONcoder2].self, from: data!){
                    //print(json)
                    for courses in json{
                        var courseitem:[JSONcoder2.Time] = []
                        
                        for course in courses.time{
                            if course.semester == "10"{
                                courseitem.append(course)
                            }
                        }
                        
                        if !courseitem.isEmpty{
                            print(courseitem)
                        }
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
        }
        
        return ret
    }
    
    @IBAction func subWeekTapped(){
        if Int(currentWeek.text!)! != 1{
            var cwk = Int(currentWeek.text!)
            cwk = cwk! - 1
            currentWeek.text = String.init(cwk!)
            reloadClassView()
        }
    }
    
    @IBAction func addWeekTapped(){
        if Int(currentWeek.text!)! < 25{
            var cwk = Int(currentWeek.text!)
            cwk = cwk! + 1
            currentWeek.text = String.init(cwk!)
            reloadClassView()
        }
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
