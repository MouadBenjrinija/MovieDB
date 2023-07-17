//
//  MoviesListRouterMain.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import UIKit
import MovieDBCore

// a facade that composes scenes for the router
public protocol MoviesListSceneFactory: AnyObject {
  func makeMovieDetailsScene(for movie: Movie) -> Scene?
}

// a router manages the actual navigation/transition,
// it manages the instance of a UINavigationController for example
// it doesn't build scenes, it just pulls them from the composer through the factory protocol
// it doesn't know which exact screen will be launched for a certain event
// it just deals with the Scene protocol that encapsulates a viewController variable within.
public class MoviesListRouterMain: MovieListRouter {
  
  private weak var navigationController: UINavigationController?
  private let sceneFactory: MoviesListSceneFactory
  
  public init(navigationController: UINavigationController, sceneFactory: MoviesListSceneFactory) {
    self.navigationController = navigationController
    self.sceneFactory = sceneFactory
  }
  
  public func trigger(route: MoviesListRoute) {
    switch route {
    case .goToDetails(let movie):
      self.showDetails(for: movie)
      break
    }
  }
  
  private func showDetails(for movie: Movie) {
    guard let navigationController,
          let scene = sceneFactory.makeMovieDetailsScene(for: movie) else {
      assertionFailure("failed to make MoviesListScene at \(#function)")
      return
    }
    navigationController.pushViewController(scene.viewController, animated: true)
  }
  
}
