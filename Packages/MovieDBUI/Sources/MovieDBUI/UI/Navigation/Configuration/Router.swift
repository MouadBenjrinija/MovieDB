//
//  Router.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import Foundation

// a router manages the actual navigation/transition,
// it manages the instance of a UINavigationController for example
// it doesn't build scenes, it just pulls them from the composer through the factory protocol
// it doesn't know which exact screen will be launched for a certain event
// it just deals with the Scene protocol that encapsulates a viewController variable within.
public protocol Router: AnyObject {
  associatedtype RouteModel: Route
  func trigger(route: RouteModel)
}
