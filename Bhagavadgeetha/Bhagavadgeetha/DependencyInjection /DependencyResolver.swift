//
//  DependencyResolver.swift
//  Bhagavadgeetha
//
//  Created by Vinit Shanbhag on 13/10/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation

protocol DependencyResolver {
    var dataBaseManager: DBManagerType { get }
}

private let _dataBaseManager = DBDataProvider()

extension DependencyResolver {
    public var dataBaseManager: DBManagerType {
        return _dataBaseManager
    }
}
