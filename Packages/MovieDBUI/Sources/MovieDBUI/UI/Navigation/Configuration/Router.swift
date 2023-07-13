//
//  Router.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import Foundation

public protocol Router: AnyObject {
  associatedtype AnyRoute: Route
  func trigger(route: AnyRoute)
  func start()
}
