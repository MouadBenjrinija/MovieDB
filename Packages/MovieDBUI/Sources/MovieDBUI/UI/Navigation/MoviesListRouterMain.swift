//
//  MoviesListRouterMain.swift
//  MovieDB
//
//  Created by Mouad Bj on 15/3/2023.
//

import UIKit
import MovieDBCore

// a facade that composes depdencies for the router
public protocol MoviesListDependencyFactory: AnyObject {
  func makeMoviesListScene(with router: any MovieListRouter) -> Scene?
  func makeMovieDetailsRouter(for movie: Movie, navigationController: UINavigationController) -> any MovieDetailsRouter
}

// a router manages the actual navigation/transition,
// it manages the instance of a UINavigationController for example
// it doesn't build dependencies, it just pulls them from the composer through the factory protocol
// it doesn't know which screen will be launched for a certain event.
public class MoviesListRouterMain: MovieListRouter {
  
  private weak var navigationController: UINavigationController?
  private let dependencyFactory: MoviesListDependencyFactory
  
  public init(navigationController: UINavigationController, dependencyFactory: MoviesListDependencyFactory) {
    self.navigationController = navigationController
    self.dependencyFactory = dependencyFactory
  }
  
  public func start() {
    guard let scene = dependencyFactory.makeMoviesListScene(with: self),
          let navigationController else {
      assertionFailure("failed to make MoviesListScene at \(#function)")
      return
    }
    navigationController.pushViewController(scene.viewController, animated: true)
  }
  
  public func trigger(route: MoviesListRoute) {
    switch route {
    case .goToDetails(let movie):
      guard let navigationController else
      {
        assertionFailure("failed to make MoviesListScene at \(#function)")
        return
      }
      let movieDetailsRouter = dependencyFactory.makeMovieDetailsRouter(
        for: movie,
        navigationController: navigationController)
      movieDetailsRouter.start()
      break
    }
  }
}
