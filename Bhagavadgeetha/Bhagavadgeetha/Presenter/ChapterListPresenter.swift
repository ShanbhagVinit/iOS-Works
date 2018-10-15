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
    var dataProvider = Container.resolver.dataBaseManager
    
    
    func getChapters() -> [Chapter] {
        let chapterData = dataProvider.readChapters()
        return chapterData
    }
}
