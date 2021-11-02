//
//  TimeViewController.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/11/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(self.slidingViewController().panGesture)
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        var frame: CGRect = (self.navigationController?.navigationBar.frame)!
//        frame.origin.y = 20
//        
//        self.navigationController?.navigationBar.frame = frame
//        
//   //     print(NSStringFromCGRect((self.navigationController?.navigationBar.frame)!))
//        
//   //     print(UIApplication.sharedApplication().statusBarFrame.height)
//    //    print(NSStringFromCGRect(self.view.bounds))
//    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
//    
//    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
//        return .Fade
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func onBtnMenu() {
        self.slidingViewController().anchorTopViewToRightAnimated(true)
    }
    
    @IBAction func onBtnTime(sender: AnyObject!) {
        let button = sender as! UIButton

        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let videos = delegate.videos[button.tag]
        
        if videos.count == 0{
            showAlertButtonTapped(button)
        }else{
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
            viewController.videos = videos
            viewController.selected_time = button.currentTitle as String!
        
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
