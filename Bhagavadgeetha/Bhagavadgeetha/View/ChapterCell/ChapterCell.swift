//
//  ChapterCell.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 3/17/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation
import UIKit

struct ChapterCellViewModel {
    var chapterDetails: String
    var isFavChapterCell: Bool
}

class ChapterCell: UITableViewCell, ConfigurableCell {
    static var nib: UINib {
        return UINib.init(nibName: "ChapterCell", bundle: Bundle.main)
    }
    
    @IBOutlet private weak var chapterName: UILabel!
    @IBOutlet private weak var favButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favButton.isSelected = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        favButton.isSelected = selected
    }
    
    func configure(with data: ChapterCellViewModel) {
        chapterName.text = data.chapterDetails
        favButton.isSelected = data.isFavChapterCell
    }
}

