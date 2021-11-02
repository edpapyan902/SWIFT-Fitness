//
//  HistoryViewController.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/11/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var historyview: UITableView!
    
    var data: NSMutableDictionary! = nil
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory:AnyObject = paths[0]
        let path = documentsDirectory.stringByAppendingPathComponent("history.plist")
        //Retrieve contents from file at specified path
        data = NSMutableDictionary(contentsOfFile: path)
        if data == nil{
            data = [:]
            return
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return data.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("historycell", forIndexPath: indexPath) as! historycell
        
        
        let dataDic = data.objectForKey("item\((data?.count)! - 1 - indexPath.row)")
        let urlstr = dataDic?.objectForKey("thumbnail") as? String
   
        let url = NSURL(string: urlstr!)
        let data1 = NSData(contentsOfURL: url!)
        cell.thumbnail.image = UIImage(data: data1!)
        

        
        
        cell.title.text = dataDic?.objectForKey("title") as? String
        cell.time.text = dataDic?.objectForKey("time") as? String
        cell.date.text = dataDic?.objectForKey("date") as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("YoutubeViewController") as! YoutubeViewController
        let dataDic = data.objectForKey("item\((data?.count)! - 1 - indexPath.row)")
        
        viewController.videoId = dataDic?.objectForKey("videoId") as? String
        viewController.videotitle = dataDic?.objectForKey("title") as? String
        viewController.start_time = dataDic?.objectForKey("start_time") as? Int
        viewController.end_time = dataDic?.objectForKey("end_time") as? Int
        viewController.history_flag = false
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBtnBack(){
        self.dismissViewControllerAnimated(true) {
            
        }
    }
    

}
