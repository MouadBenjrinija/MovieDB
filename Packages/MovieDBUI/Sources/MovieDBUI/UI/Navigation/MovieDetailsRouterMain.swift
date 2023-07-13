//
//  File.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import UIKit
import MovieDBCore

// a facade that composes depdencies for the router
public protocol MovieDetailsDependencyFactory: AnyObject {
  func makeMovieDetailsScene(for movie: Movie, router: some MovieDetailsRouter) -> Scene?
}

// a router manages the actual navigation/transition,
// it manages the instance of a UINavigationController for example
// it doesn't build dependencies, it just pulls them from the composer through the factory protocol
// it doesn't know which screen will be launched for a certain event.
public class MovieDetailsRouterMain: MovieDetailsRouter {
  
  private let movie: Movie
  private weak var navigationController: UINavigationController?
  private let dependencyFactory: MovieDetailsDependencyFactory
  
  public init(movie: Movie,
              navigationController: UINavigationController,
              dependencyFactory: MovieDetailsDependencyFactory) {
    self.movie = movie
    self.navigationController = navigationController
    self.dependencyFactory = dependencyFactory
  }
  
  public func start() {
    guard let scene = dependencyFactory.makeMovieDetailsScene(for: movie, router: self),
          let navigationController else {
      assertionFailure("failed to make MoviesListScene at \(#function)")
      return
    }
    navigationController.pushViewController(scene.viewController, animated: true)
  }
  
  public func trigger(route: MovieDetailsRoute) {
    switch route {
    case .goBack:
      guard let navigationController else {
        assertionFailure("NavController not retained at \(#function)")
        return
      }
      navigationController.popViewController(animated: true)
      break
    }
  }
  
  deinit {
    print("MovieDetailsRouterMain cleared")
  }
  
}
