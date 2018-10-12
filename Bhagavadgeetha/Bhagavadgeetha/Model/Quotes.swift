//
//  Quotes.swift
//  SqliteDBExample
//
//  Created by Shanbhag's Mac on 10/2/17.
//  Copyright © 2017 Shanbhag's Mac. All rights reserved.
//

import Foundation

class Quotes {
    var serialNumber : Int
    var chapterNumber : Int
    var chapterWiseSerialNumber : Int
    var quote : String
    
    init(serial : Int , chapterNum : Int, chapterSerNum : Int , quote : String)
    {
        self.serialNumber = serial
        self.chapterNumber = chapterNum
        self.chapterWiseSerialNumber = chapterSerNum
        self.quote = quote
    }
}

