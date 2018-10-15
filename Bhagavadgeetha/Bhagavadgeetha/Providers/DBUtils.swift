//
//  DBUtils.swift
//  SqliteDBExample
//
//  Created by Shanbhag's Mac on 10/1/17.
//  Copyright © 2017 Shanbhag's Mac. All rights reserved.
//

import Foundation
import SQLite3

protocol DBManagerType {
    func readChapters() -> [Chapter]
    func getQuotes(from Chapter: Int) -> [Quotes]
}

class DBDataProvider: DBManagerType {
    
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
    
    func readChapters() -> [Chapter] {
        var db : OpaquePointer? = nil
        var chaptersArray : [Chapter] = []
        if(sqlite3_open(dbPath, &db) == SQLITE_OK){
            print("Succesfully opened Connection")
            var queryStatement :OpaquePointer? = nil
            let queryStatementString1 = "SELECT * FROM chapters;"
            _ = "SELECT COUNT(*) FROM chapters;"
            
            if(sqlite3_prepare_v2(db, queryStatementString1, -1,  &queryStatement , nil) == SQLITE_OK){
                
                while(sqlite3_step(queryStatement) == SQLITE_ROW)
                {
                    let num = Int(sqlite3_column_int(queryStatement, 0))
                    let name = String(cString :sqlite3_column_text(queryStatement, 1)!)
                    
                    let chapter = Chapter(number: num, name: name)
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
    
    /* find the reference https://www.sqlite.org/c3ref/prepare.html to know more about
       the method params and their significance */
    func getQuotes(from chapter: Int) -> [Quotes] {
        var db: OpaquePointer? = nil
        var quotesArray: [Quotes] = []
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            print("Successfully opened conection")
            var queryStatment : OpaquePointer? = nil
            let statement = "select meaning, sloka_sanskrit, sloka_eng from quotes where ch_no='\(chapter)'"
            print(statement)
            if sqlite3_prepare_v2(db , statement, -1, &queryStatment, nil) == SQLITE_OK {
                while sqlite3_step(queryStatment) == SQLITE_ROW {
                    var meaning = ""
                    var sanskrit_sloka: String = ""
                    var eng_sloka: String = ""
                    if let cStringMeaning = sqlite3_column_text(queryStatment, 0), let cStringSanskrit = sqlite3_column_text(queryStatment, 1), let cStringEnglish = sqlite3_column_text(queryStatment, 2)  {
                       meaning = String(cString: cStringMeaning)
                       sanskrit_sloka = String(cString: cStringSanskrit)
                       eng_sloka = String(cString: cStringEnglish)
                    }
                    let quote = Quotes(meaning: meaning, sanskrit_sloka: sanskrit_sloka, eng_sloka: eng_sloka)
                    quotesArray.append(quote)
                }
            }else {
                print("Didn't execute")
            }
            sqlite3_finalize(queryStatment)
        } else {
            print("Error in opening connection")
        }
        sqlite3_close(db)
        return quotesArray
    }
}
