//
//  CahptersTableViewController.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 2/28/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import UIKit

class ChaptersViewController: UIViewController, ChapterListViewDelegate {         
    
    var chapterListView: ChapterListView?
    var chapterListPresnterType: ChapterListDelegate = ChapterListPresenter()
    private var chapters: [Chapter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chapters"
        let nib = UINib.init(nibName: "ChapterListView", bundle: Bundle.main)
        if let chaptersTableView = nib.instantiate(withOwner: nil, options: nil).first as? ChapterListView {
            chapterListView = chaptersTableView
            self.view.addSubview(chaptersTableView)
            chaptersTableView.translatesAutoresizingMaskIntoConstraints = false
            chaptersTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            chaptersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            chaptersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            chaptersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        }
        
        setUpChaptersView()
    }
    
    
    func setUpChaptersView() {
        chapterListView?.delegate = self
        chapters = chapterListPresnterType.getChapters()
        let chapterViewModel: [ChapterCellViewModel] = chapters.map {chapter in
                let chapterDetail = " \(chapter.number) | \(chapter.name)"
            return ChapterCellViewModel(chapterDetails: chapterDetail, isFavChapterCell: false)
        }
        chapterListView?.configure(with: chapterViewModel)
    }
    
    // MARK: - Table view data source
    
    func selectedItem(with Index: Int) {
       let chapter = chapters[Index]
       let readViewController = ReaderViewController(chapterId: chapter.number)
       self.navigationController?.pushViewController(readViewController, animated: true)
    }
}
