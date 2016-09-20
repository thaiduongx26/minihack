//
//  database.swift
//  mini-hack
//
//  Created by Admin on 9/19/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class Database {
    class func getPath(fileName: String) -> String {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent(fileName)
        return fileURL.path!
    }
    class func copyFile(fileName: NSString) {
        let dbPath: String = getPath(fileName as String)
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(dbPath) {
            let documentsURL = NSBundle.mainBundle().resourceURL
            let fromPath = documentsURL!.URLByAppendingPathComponent(fileName as String)
            var error : NSError?
            do {
                try fileManager.copyItemAtPath(fromPath.path!, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            if (error != nil) {
                print("Error Occured")
                print("\(error?.localizedDescription)")
            } else {
                print("Successfully Copy")
                print("Your database copy successfully")
            }
            
        }
    }

}


