//
//  CustomCell.swift
//  ExpandableTableViewCell
//
//  Created by Vinit Shanbhag on 29/09/18.
//  Copyright © 2018 Vinit Shanbhag. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var secondView: UIView!
  
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondViewLabel: UILabel!
    
    @IBOutlet weak var firstViewLabel: UILabel!
    @IBOutlet weak var secongLabelHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var showDetails: Bool = false {
        didSet{
            secongLabelHeightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(showDetails ? 250 : 999))
        }
    }

}
