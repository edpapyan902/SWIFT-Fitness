//
//  VideoViewController.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/11/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit



class VideoViewController: UIViewController {
    
 //   var video: Video! = nil
    var urlstring: String! = nil
    var selected_time: String! = nil
    var content: [Content]! = nil
    
    
    var index = 0
    var flag = 0
    
    
    
    
    
    var youtubeId:String! = nil
    var videotitle: String! = nil
    var time: String! = nil
    var thumbnail: String! = nil
    
    var start_time: Int! = nil
    var end_time: Int! = nil

    @IBOutlet weak var titleLabel: UILabel!
    
    //https://noembed.com/embed?url=https://www.youtube.com/watch?v=I482t6JhL4g
    
    override func viewDidLoad() {
        super.viewDidLoad()
        index = Int(arc4random_uniform(UInt32(content.count)))
        
        videoInfoGet()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
       
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipBtn(sender: AnyObject) {
        if content.count > 1{
            var new_index = 0
            repeat {
                new_index = Int(arc4random_uniform(UInt32(content.count)))
            } while index == new_index
            
            index = new_index
            

            videoInfoGet()
        }
        
    }
    
    
    func videoInfoGet(){
        
        
        
        
        //   get video ID-------
        let pattern: String = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
            if let regexMatch = regex.firstMatchInString(content[index].youtubeLink, options: NSMatchingOptions(rawValue: 0), range: NSRange(location: 0, length: content[index].youtubeLink.characters.count)) {
                youtubeId = (content[index].youtubeLink as NSString).substringWithRange(regexMatch.range)
            }
        }
        catch let error as NSError{
            print("Error while extracting youtube id \(error.debugDescription)")
        }
        
        
        // get title--------------------------
        let urlString = "https://noembed.com/embed?url=https://www.youtube.com/watch?v=" + youtubeId
        let url = NSURL(string: urlString)
        
        do{
            let infoData = try NSData(contentsOfURL: url!, options: NSDataReadingOptions())
            let infoDictionary = try! NSJSONSerialization.JSONObjectWithData(infoData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            let title = infoDictionary.objectForKey("title") as! NSString
            videotitle = title as String
            
        }catch {
            
        }

            // get shown time
        
        
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: date)
            //   let year =  components.year
            //    let month = components.month
            let month = NSDateFormatter().monthSymbols[components.month - 1]
        
            let index1 = month.startIndex.advancedBy(3)
        
            let substring1 = month.substringToIndex(index1)
        
        
            let day = String(components.day)
            time = substring1 + " " + day
        
            // get thumbnail
            thumbnail = "\("http://img.youtube.com/vi/")\(youtubeId)\("/default.jpg")"
        
        
            
        //title view-----------------
        let myString = "Video: " + videotitle
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(
            string: myString,
            attributes: [NSFontAttributeName:UIFont(
                name: "Avenir Next",
                size: 18.0)!])
        myMutableString.addAttribute(NSFontAttributeName,
                                     value: UIFont(
                                        name: "AvenirNext-Bold",
                                        size: 18.0)!,
                                     range: NSRange(
                                        location:0,
                                        length:7))
        myMutableString.addAttribute(NSForegroundColorAttributeName,
                                     value: UIColor.whiteColor(),
                                     range: NSRange(
                                        location:0,
                                        length:myString.characters.count))
        
        self.titleLabel.attributedText = myMutableString
     
        
        
  //      self.titleLabel.text = "Video: " + videotitle
        titleLabel.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        titleLabel.numberOfLines = 0
        
  //      titleLabel.textColor = UIColor.whiteColor()
  //      titleLabel.font = UIFont(name:(titleLabel.font?.fontName)!, size: 18)
        
        
        

    }
    

    @IBAction func plankBtn(sender: AnyObject) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if delegate.plank == false {
            showAlertButtonTapped()
            delegate.plank = true
        }else{
            plank()
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "Plank!") {
//        }
//    }
    
    func plank(){
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("YoutubeViewController") as! YoutubeViewController
        //       if content[index].endTime == "" {
        //          urlstring = "\("https://www.youtube.com/v/")\(youtubeId)"
        //      }else{
        
        let start_index = content[index].startTime.rangeOfString(":", options: .BackwardsSearch)?.startIndex
        let start_min = content[index].startTime.substringToIndex(start_index!)
        let start_sec = content[index].startTime.substringFromIndex(start_index!.advancedBy(1)).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        start_time = Int(start_min)! * 60 + Int(start_sec)!
        
        let end_index = content[index].endTime.rangeOfString(":", options: .BackwardsSearch)?.startIndex
        let end_min = content[index].endTime.substringToIndex(end_index!)
        let end_sec = content[index].endTime.substringFromIndex(end_index!.advancedBy(1)).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        end_time = Int(end_min)! * 60 + Int(end_sec)!
        
        urlstring = "\("https://www.youtube.com/embed/")\(youtubeId)\("?start=")\(start_time)\("&end=")\(end_time)"
        //      }
        
        
        viewController.videotitle = videotitle
        viewController.videoId = youtubeId
        viewController.thumbnail = thumbnail
        viewController.start_time = start_time
        viewController.end_time = end_time
        viewController.time = time
        viewController.selected_time = selected_time
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func showAlertButtonTapped() {
        
        // create the alert
        let alert = UIAlertController(title: "Quick Tip!", message: "Start your plank once the timer counts down from 3. After your allotted time, the video will end and your plank is complete.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            self.plank()
        }))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    @IBAction func onBtnBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }


}
