//
//  YoutubeViewController.swift
//  Do You Even Plank
//
//  Created by iDeveloper on 8/12/16.
//  Copyright © 2016 iDeveloper. All rights reserved.
//

import UIKit
import YouTubePlayer
import AVFoundation


class YoutubeViewController: UIViewController, YouTubePlayerDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var player: YouTubePlayerView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 3
    var timer = NSTimer()
    var timerIsOn = false
    
    var audioPlayer: AVAudioPlayer! // Global variable
    
    
    var videotitle: String! = nil
    var thumbnail: String! = nil
    var selected_time: String! = nil
    var time: String! = nil
    var start_time: Int! = nil
    var end_time: Int! = nil
    
    var historyindex = 0
    var history_flag = true
    
    var videoId: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.layer.zPosition = 1
 //------Play sound on iPhone even in silent mode---------
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
  //------------------------
        
        self.title = videotitle
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 51.0/255.0, green: 204.0/255.0, blue: 255.0/255.0, alpha: 1.0)]
        
        player.delegate = self
        player.playerVars = [
            "start": start_time,
            "end" : end_time,
            "playsinline": "1",
            "controls": "1",
            "showinfo": "0"
        ]
        player.loadVideoID(videoId)
        player.play()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateTimer(){
        
        
        if seconds < 0 {
            timer.invalidate()
            timerLabel.text = ""
        }else {
  //----adding sound-------------------
            do {
                if seconds == 0 {
                    self.audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("total", ofType: "wav")!))
                }else{
                    self.audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep-piano", ofType: "aif")!))
                }
                
                self.audioPlayer.play()
                
            } catch {
                print("Error")
            }

  //----------------animate text adding-------------
            if seconds == 0 {
                
//                let str = NSAttributedString(string: "Plank!", attributes: [
//                    NSStrokeColorAttributeName : UIColor.whiteColor(),
//                    NSStrokeWidthAttributeName : -2,
//                    NSFontAttributeName : UIFont.systemFontOfSize(40.0)
//                    ])
//                timerLabel.attributedText = str
                
                timerLabel.font = UIFont(name:(timerLabel.font?.fontName)!, size: 90)
                    self.timerLabel.alpha = 1.0
                    self.timerLabel.text = "Plank!"
                    UIView.animateWithDuration(1, animations: { () -> Void in
                        self.timerLabel.alpha = 0.0
                        }, completion: { (_) -> Void in
                            
                    })
                
                
            }else{
//                let str = NSAttributedString(string: "\(seconds)", attributes: [
//                    NSStrokeColorAttributeName : UIColor.whiteColor(),
//                    NSStrokeWidthAttributeName : -2,
//                    NSFontAttributeName : UIFont.systemFontOfSize(70.0)
//                    ])
//                timerLabel.attributedText = str
                
                timerLabel.font = UIFont(name:(timerLabel.font?.fontName)!, size: 120)
                self.timerLabel.alpha = 1.0
                
                self.timerLabel.text = "\(self.seconds)"
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.timerLabel.alpha = 0.0
                        }, completion: { (_) -> Void in
                           
                    })
                
            }
            seconds -= 1
        }
    }
    
    func playerReady(videoPlayer: YouTubePlayerView) {
        videoPlayer.play()
    }
    
    func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
        if playerState == YouTubePlayerState.Playing && timerIsOn == false{
            videoPlayer.pause()
            
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(YoutubeViewController.updateTimer)), userInfo: nil, repeats: true)
            
  //-----------delay calling function for 4 seconds---------------
            let triggerTime = (Int64(NSEC_PER_SEC) * 5)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                videoPlayer.play()
            })
  //-------------------------
        
            timerIsOn = true
        }
        
        
        if (playerState == YouTubePlayerState.Ended) {
            
            if history_flag == true{
                //history save----------2016.8.24
                var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) //Get Path of Documents Directory
                let documentsDirectory:AnyObject = paths[0]
                let path = documentsDirectory.stringByAppendingPathComponent("history.plist")
                let fileManager = NSFileManager.defaultManager()
                let fileExists:Bool = fileManager.fileExistsAtPath(path)
                var data : NSMutableDictionary?
                
                
                //Check if plist file exists at path specified
                if fileExists == false {
                    //File does not exists
                    data = NSMutableDictionary () //Create data dictionary for storing in plist
                } else  {
                    //File exists – retrieve data from plist inside data dictionary
                    data = NSMutableDictionary(contentsOfFile: path)
                    historyindex = (data?.count)!
                }
                
                let historyData = ["title":videotitle,"thumbnail":thumbnail,"time":selected_time,"date":time,"videoId":videoId,"start_time":start_time,"end_time":end_time]
                
                data!.setValue(historyData, forKey: "item\(historyindex)")
                data!.writeToFile(path, atomically: true) //Write data to file permanently
                
                self.navigationController?.popToRootViewControllerAnimated(true)
                

            }else{history_flag = true}
        }else if playerState == YouTubePlayerState.Paused {
            
//            var frame: CGRect = (self.navigationController?.navigationBar.frame)!
//            frame.origin.y = 20
//            
//            self.navigationController?.navigationBar.frame = frame
            
            timerIsOn = true

        }
    }
    
    func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    
    @IBAction func onBtnBack(){
        
        player.stop()
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
