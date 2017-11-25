//
//  MessageViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController {

    var messageItems = [MessageItem]()
    override func viewDidLoad() {
        let item1 = MessageItem()
        item1.content="2344"
        item1.title="1233"
        self.messageItems.append(item1)
        let item2 = MessageItem()
        item2.content="该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！该交作业了！！"
        item2.title="助教 王芷芙"
        self.messageItems.append(item2)
        
        tableView.rowHeight = 120
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.messageItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell", for: indexPath) as? MessageViewCell

        if let title = messageItems[indexPath.row].title {
            cell?.TitleLabel.text=title
        }
        if let content = messageItems[indexPath.row].content {
            cell?.ContentLabel.text=content
        }

        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.messageItems.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
