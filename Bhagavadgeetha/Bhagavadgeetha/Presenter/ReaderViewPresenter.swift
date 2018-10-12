//
//  ReaderViewPresenter.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 4/2/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation

protocol ReaderViewPresenterType {
    func setUpChapterID(_ chapterID: Int)
}

class ReaderViewPresenter: ReaderViewPresenterType {

    private var chapterID: Int = 0
    
    func setUpChapterID(_ chapterID: Int) {
        self.chapterID = chapterID
    }
    
}
