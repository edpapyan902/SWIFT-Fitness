//
//  ContentViewController.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/11/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//
import UIKit

class Content: NSObject {
    var type: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var youtubeLink: String = ""
}


class ContentViewController: UIViewController {
    
    var videos: [Video]! = nil
    var selected_time: String! = nil
    
    var contents = [[Content](),[Content](),[Content](),[Content](),[Content]()]
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        contentGet()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBtnBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func contentGet(){
        
        
        for video in videos{
            if video.type == "Sports"{
                let content : Content = Content()
                content.type = video.type
                content.startTime = video.startTime
                content.endTime = video.endTime
                content.youtubeLink = video.youtubeLink
                contents[0].append(content)
            }else if video.type == "Funny"{
                let content : Content = Content()
                content.type = video.type
                content.startTime = video.startTime
                content.endTime = video.endTime
                content.youtubeLink = video.youtubeLink
                contents[1].append(content)
            }else if video.type == "Educational"{
                let content : Content = Content()
                content.type = video.type
                content.startTime = video.startTime
                content.endTime = video.endTime
                content.youtubeLink = video.youtubeLink
                contents[2].append(content)
            }else if video.type == "Music Video"{
                let content : Content = Content()
                content.type = video.type
                content.startTime = video.startTime
                content.endTime = video.endTime
                content.youtubeLink = video.youtubeLink
                contents[3].append(content)
            }
                let content : Content = Content()
                content.type = video.type
                content.startTime = video.startTime
                content.endTime = video.endTime
                content.youtubeLink = video.youtubeLink
                contents[4].append(content)
            
        }
    }
    
    @IBAction func onBtnVideo(sender: AnyObject!) {
        let button = sender as! UIButton
        
        if contents[button.tag].count == 0{
            showAlertButtonTapped(button)
        }else{
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("VideoViewController") as! VideoViewController
            viewController.content = contents[button.tag]
            viewController.selected_time = selected_time
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        
    }
    @IBAction func showAlertButtonTapped(sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "Alert", message: "No existing video", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    
}
