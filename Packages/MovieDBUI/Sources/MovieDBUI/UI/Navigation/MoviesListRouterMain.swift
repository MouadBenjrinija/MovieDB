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
