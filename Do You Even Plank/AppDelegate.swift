//
//  AppDelegate.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/11/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var plank = false
    
    var videos = [[Video](), [Video](), [Video](), [Video](), [Video](), [Video](), [Video](), [Video](), [Video]()]
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Navigation Bar;
        UINavigationBar.appearance().tintColor = UIColor(red: 0.0 / 255.0, green: 193.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        
        // Load;
        loadSheet()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }
    
    func application(application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
    }
    
    func application(application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        
    }

    func application(application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
//        print("willChangeStatusBarFrame")
//        print(NSStringFromCGRect(newStatusBarFrame))
    }
    
    func application(application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
//        print("didChangeStatusBarFrame")
//        print(NSStringFromCGRect(oldStatusBarFrame))
    }

    func loadSheet() {
        
        let urlString = "https://spreadsheets.google.com/feeds/list/16HjsPso7jGQRJXP2Dnn_1maux0Oye_Vpr6bJzWSAsTY/1/public/values?alt=json"
        let url = NSURL(string: urlString)
        
        let keys = ["time" , " genre", " starttime", " endtime"]
        let time = ["0:30" , "0:45", "1:00", "1:15" , "1:30", "1:45", "2:00", "2:30", "3:00"]
        
  /*      let keys = ["_cokwr" , " _cpzh4" , " _cre1l" , " seconds_2" , " _ciyn3" , " _ckd7g" , " _clrrx" , " _cyevm" , " _cztg3" , " _d180g" , " _d2mkx" , " _cssly" , " _cu76f" , " _cvlqs" , " _cx0b9" , " _d9ney" , " _db1zf" , " _dcgjs" , " _ddv49" , " _d415a" , " _d5fpr" , " _d6ua4" , " _d88ul" , " _dkvya" , " _dmair" , " _dnp34" , " _dp3nl" , " _df9om" , " _dgo93" , " _di2tg" , " _djhdx" , " _dw4je" , " _dxj3v" , " _dyxo8" , " _e0c8p"]  */
        
        do {
            let sheetData = try NSData(contentsOfURL: url!, options: NSDataReadingOptions())
            let sheetDictionary = try! NSJSONSerialization.JSONObjectWithData(sheetData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            let feedDictionary = sheetDictionary.objectForKey("feed") as! NSDictionary
            let entryArray = feedDictionary.objectForKey("entry") as! NSArray
            
   //         var header: Bool = true
            
            for entry in entryArray {
                var columns = ["", "" , "" , "" , ""]
                
                let entryDictionary = entry as! NSDictionary
                
                // Title;
                let titleDictionary = entryDictionary.objectForKey("title")
                let title = titleDictionary?.objectForKey("$t") as! String
                columns[0] = title
                
                // Content;
                let contentDictionary = entryDictionary.objectForKey("content")
                let content = contentDictionary?.objectForKey("$t") as! String
                let components = content.componentsSeparatedByString(",")
                for component in components {
                    let index = component.rangeOfString(": ", options: .BackwardsSearch)?.startIndex
                    let key = component.substringToIndex(index!)
                    let value = component.substringFromIndex(index!.advancedBy(2)).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    columns[keys.indexOf(key)! + 1] = value
                }
                
                
                // Video;
                let video: Video = Video()
                video.type = columns[2]
                video.startTime = columns[3]
                video.endTime = columns[4]
                video.youtubeLink = columns[0]
                
                // Append;
                videos[time.indexOf(columns[1])!].append(video)

                
                
        /*        if (header) {
                    header = false
                    continue
                }   */
                
     /*           for index in 0..<9 {
                    // Video;
                    let video: Video = Video()
                    video.type = columns[index * 4 + 0]
                    video.startTime = columns[index * 4 + 1]
                    video.endTime = columns[index * 4 + 2]
                    video.youtubeLink = columns[index * 4 + 3]
                    
                    // Append;
                    videos[index].append(video)
                }  */
            }
            
        } catch {
            
        }
    }

}

