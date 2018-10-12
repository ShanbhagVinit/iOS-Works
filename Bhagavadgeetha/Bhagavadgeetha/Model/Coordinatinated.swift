//
//  TableViewCoordination.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 3/16/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import  UIKit

public protocol TableViewCoordinated {
    associatedtype CellDataProvider: SectionDataProvider
    associatedtype CellType: UITableViewCell, ConfigurableCell
}


public protocol SectionDataProvider {
    associatedtype DataObject
    func ItemAt(index: Int) -> DataObject?
    func numberOfItems() -> Int
}

public protocol ConfigurableCell {
    associatedtype DataObject
    func configure(with data: DataObject)
    static var nib: UINib {get }
}
extension Array: SectionDataProvider {
    public func ItemAt(index: Int) -> Element? {
       return self[index]
    }
    
    public func numberOfItems() -> Int {
        return count
    }
}
