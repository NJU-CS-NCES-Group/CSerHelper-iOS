//
//  DownloadViewController.swift
//  CSerHelper_ios
//
//  Created by 吴佳玮 on 2017/11/19.
//  Copyright © 2017年 吴佳玮. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var downloadItems = [DownloadItem]()
    
    lazy var downloadSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    
    override func viewDidLoad() {
        downloadItems = getItems()
        tableView.rowHeight = 70
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItems() -> [DownloadItem] {
        var ret = [DownloadItem]()
        ret.append(DownloadItem.init(name: "123",fileUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511560600047&di=cc780016113e37d33ccddc8d4b81e5ad&imgtype=0&src=http%3A%2F%2Fimg4.178.com%2Fgw2%2F201303%2F156983482582%2F156983527013.jpg"))
        ret.append(DownloadItem.init(name: "123",fileUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511560600047&di=cc780016113e37d33ccddc8d4b81e5ad&imgtype=0&src=http%3A%2F%2Fimg4.178.com%2Fgw2%2F201303%2F156983482582%2F156983527013.jpg"))
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

extension DownloadViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadViewCell", for: indexPath) as? DownloadViewCell
        
        cell?.delegate = self
        
        if let name = downloadItems[indexPath.row].name {
            cell?.fileName.text=name
        }
         if downloadItems[indexPath.row].isDownloading == true{
            cell?.indicator.isHidden=false
            cell?.downloadButton.isHidden=true
            cell?.openButton.isHidden=true
            cell?.indicator.startAnimating()
         }
         else{
            cell?.indicator.stopAnimating()
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
        return cell!
    }
    
    
}

extension DownloadViewController : URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("finish download")
        if let url = downloadTask.originalRequest?.url?.absoluteString{
            let index = getIndexByURL(url: url)
            downloadItems[index!].isDownloading = false
            downloadItems[index!].isDownloaded = true
            DispatchQueue.main.async {
                self.reload(index!)
            }
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

extension DownloadViewController : DownloadViewDelegate {
    
    
    func downloadTapped(_ cell: DownloadViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            downloadItems[indexPath.row].isDownloading = true
            downloadItems[indexPath.row].isDownloaded = true
            startDownload(item: downloadItems[indexPath.row])
            self.reload(indexPath.row)
        }
        print("downloadtapped")
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
        print("startdownload")
    }
    
}
