//
//  TableViewCoordination.swift
//  Bhagavadgeetha
//
//  Created by Shanbhag's Mac on 3/16/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation
import UIKit

public class  TableVieWCoordinator<Coordination: TableViewCoordinated>: NSObject, UITableViewDataSource where Coordination.CellType.DataObject == Coordination.CellDataProvider.DataObject {
    
    private var reuseIdentifier: String
    var cellDataProvider: Coordination.CellDataProvider?
    
    public init(reuseIdentifier: String = String(describing: Coordination.CellType.self)) {
        self.reuseIdentifier = reuseIdentifier
    }
    
    public func registerCell(for tableView: UITableView) {
        tableView.register(Coordination.CellType.nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? Coordination.CellType else {
            fatalError("Cannot Dequeue cell of Type \(Coordination.CellType.self) with reuseIdentifier \(reuseIdentifier)" )
        }
        
        if let provider = cellDataProvider, indexPath.row < provider.numberOfItems(), let cellData = provider.ItemAt(index: indexPath.row) {
            cell.configure(with: cellData)
        }
    
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return cellDataProvider?.numberOfItems() ?? 0
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
