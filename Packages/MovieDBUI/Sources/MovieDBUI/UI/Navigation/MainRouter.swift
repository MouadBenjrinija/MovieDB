//
//  MainRouter.swift
//  
//
//  Created by Mouad Bj on 17/7/2023.
//

import UIKit

// a facade that composes scenes for the router
public protocol MainRouterSceneFactory: AnyObject {
  func makeMoviesListScene() -> Scene?
}

public enum MainRoute: Route {
  case moviesList
}

// entry point router
public class MainRouter: Router {
  
  private weak var navigationController: UINavigationController?
  private weak var sceneFactory: MainRouterSceneFactory?
  
  public init(navigationController: UINavigationController, sceneFactory: MainRouterSceneFactory) {
    self.navigationController = navigationController
    self.sceneFactory = sceneFactory
  }
  
  public func trigger(route: MainRoute) {
    switch route {
    case .moviesList: showMoviesList()
    }
  }
  
  func showMoviesList() {
    guard let scene = sceneFactory?.makeMoviesListScene(),
          let navigationController else {
      assertionFailure("unable to show MoviesList Scene at \(#function)")
      return
    }
    navigationController.pushViewController(scene.viewController, animated: true)
  }
  
}
