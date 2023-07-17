//
//  File.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import UIKit
import MovieDBCore

// a facade that composes scenes for the router
public protocol MovieDetailsSceneFactory: AnyObject {
}

// a router manages the actual navigation/transition,
// it manages the instance of a UINavigationController for example
// it doesn't build scenes, it just pulls them from the composer through the factory protocol
// it doesn't know which exact screen will be launched for a certain event
// it just deals with the Scene protocol that encapsulates a viewController variable within.
public class MovieDetailsRouterMain: MovieDetailsRouter {
  
  private weak var navigationController: UINavigationController?
  private let sceneFactory: MovieDetailsSceneFactory
  
  public init(navigationController: UINavigationController,
              sceneFactory: MovieDetailsSceneFactory) {
    self.navigationController = navigationController
    self.sceneFactory = sceneFactory
  }
  
  public func trigger(route: MovieDetailsRoute) {
    switch route {
    case .goBack: popScene()
    }
  }
  
  private func popScene() {
    guard let navigationController else {
      assertionFailure("NavController not retained at \(#function)")
      return
    }
    navigationController.popViewController(animated: true)
  }
  
  deinit {
    print("MovieDetailsRouterMain cleared")
  }
  
}
