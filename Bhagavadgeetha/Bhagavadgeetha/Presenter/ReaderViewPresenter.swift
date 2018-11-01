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
    func getQuote(for index: Int) -> String
    func numberOfQuotes() -> Int
}

struct FillTextViewOptions: OptionSet {
    let rawValue: Int

    static let sanskritText = FillTextViewOptions(rawValue: 1 << 0)
    static let englishText = FillTextViewOptions(rawValue: 1 << 1)
    static let meaningText = FillTextViewOptions(rawValue: 1 << 2)
}

class ReaderViewPresenter: ReaderViewPresenterType {

    private var chapterID: Int = 0
    private let dbManager = Container.resolver.dataBaseManager
    private var quotesArray: [Quotes] = []
    private let formatter = "\n\n"
    
    
    public func setUpChapterID(_ chapterID: Int) {
        self.chapterID = chapterID
        quotesArray = dbManager.getQuotes(from: chapterID)
    }
    
    public func getQuote(for index: Int) -> String {
        var quote: String = " "
        var fillTextViewOptions: [FillTextViewOptions] = []
        if quotesArray[index].sanskrit_sloka != "" {
            fillTextViewOptions.append(.sanskritText)
            quote = "Sanskrit Version:\(formatter)\(quotesArray[index].sanskrit_sloka)\(formatter)"
        }
        if quotesArray[index].eng_sloka != "" {
            fillTextViewOptions.append(.englishText)
            quote = quote.appending("English version: \(formatter)\(quotesArray[index].eng_sloka)\(formatter)")
        }
        if quotesArray[index].meaning != "" {
            fillTextViewOptions.append(.meaningText)
            quote = quote.appending("Meaning: \(formatter)\(quotesArray[index].meaning)\(formatter)")
        }
        return quote
    }
    
    public func numberOfQuotes() -> Int {
        return quotesArray.count
    }
    
}
