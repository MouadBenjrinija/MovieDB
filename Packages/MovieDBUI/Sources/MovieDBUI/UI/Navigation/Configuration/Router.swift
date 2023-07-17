//
//  Router.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import Foundation

public protocol Router: AnyObject {
  associatedtype RouteModel: Route
  func trigger(route: RouteModel)
  func start()
}
