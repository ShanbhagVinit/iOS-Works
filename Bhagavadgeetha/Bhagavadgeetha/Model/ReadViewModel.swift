//
//  ReadViewModel.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 4/2/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation

public struct ReadViewModel {
    var id: Int
    var chapterNumber: Int
    var meaning: String
    var isFavourite: Bool
    var sanskritVersion: String
    var englishVersion: String
    
    public init(id: Int, chapterNum: Int, meaning: String, isFav: Bool = false, sanskritVersion: String = String.empty, englishVersion: String = .empty) {
        self.id = id
        self.chapterNumber = chapterNum
        self.meaning = meaning
        self.isFavourite = isFav
        self.sanskritVersion = sanskritVersion
        self.englishVersion = englishVersion
    }
}

public extension String {
    
    public static var empty: String {
        return ""
    }
}
