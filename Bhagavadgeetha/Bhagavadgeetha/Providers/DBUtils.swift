//
//  DBUtils.swift
//  SqliteDBExample
//
//  Created by Shanbhag's Mac on 10/1/17.
//  Copyright © 2017 Shanbhag's Mac. All rights reserved.
//

import Foundation
import SQLite3

class DBDataProvider {
    
    var dbPath : String
    
     init() {
        var path : Array = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let directory : String = path[0]
        dbPath = (directory as NSString).appendingPathComponent("gita.sqlite")
        print(dbPath)
        
        if (FileManager.default.fileExists(atPath: dbPath))
        {
            print("Exits")
        }
        else{
            let pathfrom:String=(Bundle.main.resourcePath! as NSString).appendingPathComponent("gita.sqlite")
            print(pathfrom)
            var success:Bool
            do {
                try FileManager.default.copyItem(atPath: pathfrom, toPath: dbPath)
                success = true
                print("copied from main bundle")
            } catch _ {
                success = false
            }
            
            if !success
            {
                print("database not create ")
            }
            else
            {
                print("Successfull database new create")
            }
        }
    }
    
    func read() -> [Chapter]?{
        var db : OpaquePointer? = nil
        var chaptersArray : Array<Chapter> = []
        if(sqlite3_open(dbPath, &db) == SQLITE_OK){
            print("Succesfully opened Connection")
            var queryStatement :OpaquePointer? = nil
            let queryStatementString1 = "SELECT * FROM chapters;"
            _ = "SELECT COUNT(*) FROM chapters;"
            
            if(sqlite3_prepare_v2(db, queryStatementString1, -1,  &queryStatement , nil) == SQLITE_OK){
                
                while(sqlite3_step(queryStatement) == SQLITE_ROW)
                {
                    let num = sqlite3_column_int(queryStatement, 0)
                    let name = String(cString :sqlite3_column_text(queryStatement, 1)!)
                    
                    let chapter = Chapter(num: Int(num),name: name)
                    chaptersArray.append(chapter)
                    
                }
            }else{
                print("didnt execute")
            }
            sqlite3_finalize(queryStatement!)
        }
        else{
            print("Fault Occured in opening connection")
        }
        sqlite3_close(db)
        return chaptersArray
    }
}
