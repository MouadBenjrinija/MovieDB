//
//  MainComposer.swift
//  MovieDB
//
//  Created by Mouad Bj on 17/7/2023.
//

import UIKit
import MovieDBCore
import MovieDBUI

class MainComposer {
  
  private let container: Container
  private weak var navigationController: UINavigationController?

  init(container: Container, navigationController: UINavigationController) {
    self.container = container
    self.navigationController = navigationController
  }
  
  func makeMainRouter() -> MainRouter {
    guard let navigationController else {
      fatalError("NavigationController not retained at \(#function)")
    }
    return MainRouter(
      navigationController: navigationController,
      sceneFactory: self)
  }
  
}

extension MainComposer: MainRouterSceneFactory {
  
  func makeMoviesListScene() -> Scene? {
    guard let navigationController else {
      assertionFailure("Failed to start app at \(#function)")
      return nil
    }
    let composer = MoviesListComposer(
      container: container,
      navigationController: navigationController)
    return composer.makeMoviesListScene()
  }
  
}
