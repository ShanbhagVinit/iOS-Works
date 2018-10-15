//
//  Container.swift
//  Bhagavadgeetha
//
//  Created by Vinit Shanbhag on 13/10/18.
//  Copyright © 2018 Shanbhag's Mac. All rights reserved.
//

import Foundation

typealias InternalDependencyResolver = DependencyResolver

struct Container {
    static var resolver: InternalDependencyResolver = DefaultDependencyResolver()
}


final class DefaultDependencyResolver: InternalDependencyResolver {
    
}
