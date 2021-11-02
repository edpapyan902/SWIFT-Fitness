//
//  MenuViewController.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/11/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var viewController: UIViewController! = nil
        
        switch indexPath.item {
        case 0:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("HistoryNavigationController")
            break
            
        case 1:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("SupportNavigationController")
            break
            
        default:
            break
        }
        
        if (viewController != nil) {
/*          self.slidingViewController().resetTopViewAnimated(true, onComplete: {
                self.slidingViewController().presentViewController(viewController, animated: true, completion: {
                })
            }) */
            
            self.slidingViewController().presentViewController(viewController, animated: true, completion: {
                
            })
        }
    }
    
    
    @IBAction func onBtnMenu() {
        self.slidingViewController().resetTopViewAnimated(true)
    }

}
