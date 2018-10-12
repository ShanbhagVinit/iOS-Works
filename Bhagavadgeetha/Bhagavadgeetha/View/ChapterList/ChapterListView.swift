//
//  CahpterListView.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 3/15/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation
import UIKit

protocol ChapterListViewDelegate {
    func selectedItem(with Index: Int)
}

class ChapterListView: UIView, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var dataCoordinator = TableVieWCoordinator<ChapterCellCoordination>()
    var delegate: ChapterListViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTableView()
    }
    
    private func setUpTableView() {
        dataCoordinator.registerCell(for: tableView)
        tableView.dataSource = dataCoordinator
        
        tableView.delegate = self
        
    }
    
    func configure(with data: [ChapterCellViewModel]) {
        dataCoordinator.cellDataProvider = data
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedItem(with: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}


