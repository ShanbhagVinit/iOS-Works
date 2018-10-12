//
//  ChapterListPresenter.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 3/18/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation

protocol ChapterListDelegate {
    func getChapters() -> [Chapter]
}

class ChapterListPresenter: ChapterListDelegate {
    
    //private var dataProvider: 
    var dataProvider = DBDataProvider()
    
    
    func getChapters() -> [Chapter] {
        guard let chapterData = dataProvider.read() else {
             return []
        }
        return chapterData
    }
}
