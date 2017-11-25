//
//  DownloadTableViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/22.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class DownloadTableViewController: UITableViewController {
    
    var downloadItems = [DownloadItem]()
    
    lazy var downloadSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    
    override func viewDidLoad() {
        
        downloadItems = getItems()
        print("1")
        print(downloadItems[0].name!)
        print(downloadItems[1].name!)
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return downloadItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadViewCell", for: indexPath) as? DownloadViewCell
        
        if let name = downloadItems[indexPath.row].name {
            cell?.fileName.text=name
        }
        /*
        if downloadItems[indexPath.row].isDownloading == true{
            cell?.indicator.isHidden=false
            cell?.downloadButton.isHidden=true
            cell?.openButton.isHidden=true
        }
        else{
            if downloadItems[indexPath.row].isDownloaded == false {
                cell?.indicator.isHidden=true
                cell?.downloadButton.isHidden=false
                cell?.openButton.isHidden=true
            }
            
            if downloadItems[indexPath.row].isDownloaded == true {
                cell?.indicator.isHidden=true
                cell?.downloadButton.isHidden=true
                cell?.openButton.isHidden=false
            }
        }
        */
        return cell!
    }
    
    func getItems() -> [DownloadItem] {
        var ret = [DownloadItem]()
        ret.append(DownloadItem.init(name: "123",fileUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511560600047&di=cc780016113e37d33ccddc8d4b81e5ad&imgtype=0&src=http%3A%2F%2Fimg4.178.com%2Fgw2%2F201303%2F156983482582%2F156983527013.jpg"))
        ret.append(DownloadItem.init(name: "123",fileUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511560600047&di=cc780016113e37d33ccddc8d4b81e5ad&imgtype=0&src=http%3A%2F%2Fimg4.178.com%2Fgw2%2F201303%2F156983482582%2F156983527013.jpg"))
        return ret
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

extension DownloadTableViewController : URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let url = downloadTask.originalRequest?.url?.absoluteString{
            let index = getIndexByURL(url: url)
            downloadItems[index!].isDownloading = false
            downloadItems[index!].isDownloaded = true
            reload(index!)
        }
    }
    
    func getIndexByURL(url:String?) -> Int? {
        for (index,item) in downloadItems.enumerated() {
            if(item.fileUrl == url){
                return index
            }
        }
        return nil
    }
    
    
}

extension DownloadTableViewController : DownloadViewDelegate {
    
    
    func downloadTapped(_ cell: DownloadViewCell) {
        self.tableView.indexPath(for: cell)
        if let indexPath = self.tableView.indexPath(for: cell) {
            downloadItems[indexPath.row].isDownloading=true
            self.reload(indexPath.row)
        }
        
    }
    
    func openTapped(_ cell: DownloadViewCell) {
        print("open this")
        //TODO: 打开文件
    }
    func reload(_ row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
    }
    
    func startDownload(item:DownloadItem){
        var downloadTask : URLSessionDownloadTask
        downloadTask = downloadSession.downloadTask(with: URL.init(string: item.fileUrl!)!)
        downloadTask.resume()
        
    }
    
}
