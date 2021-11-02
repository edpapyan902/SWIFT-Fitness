//
//  PlistManager.swift
//  RaphaelSilva
//
//  Created by Raphael Silva on 4/16/15.
//  Copyright (c) 2015 Raphael Silva. All rights reserved.
//

import Foundation

class PlistManager {
    
    var resumeDictionary: [String: AnyObject] {
        let dict = self.loadDataFromPlist()
        
        return dict
    }
    
    private func loadDataFromPlist() -> [String: AnyObject] {
        
        // getting path to GameData.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! String
        let path = documentsDirectory.stringByAppendingPathComponent("ResumeInfo.plist")
        
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("ResumeInfo", ofType: "plist") {
                
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                
                println("ResumeInfo.plist copied")
            } else {
                println("ResumeInfo.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("ResumeInfo.plist already exits at path.")
        }
        
        let dictionaryFromPlist = NSDictionary(contentsOfFile: path) as! [String: AnyObject]
//        println("Loaded ResumeInfo.plist file is --> \(dictionaryFromPlist.description)")
        
        return dictionaryFromPlist
    }
}