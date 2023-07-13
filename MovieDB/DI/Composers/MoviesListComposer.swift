//
//  MoviesListComposer.swift
//  MovieDB
//
//  Created by Mouad Bj on 4/7/2023.
//

import UIKit
import MovieDBCore
import MovieDBUI


// MARK: - Main Dependency Composer
// a composer is responsiple of building depdencies and injecting them in different components
// a composer can own multiple child composers which are created on demand
class MoviesListComposer {
  
  private let container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
  }
  
  func startApp(with navigationController: UINavigationController) {
    let router = MoviesListRouterMain(
      navigationController: navigationController,
      dependencyFactory: self)
    router.start()
  }
}

extension MoviesListComposer: MoviesListDependencyFactory {
  func makeMoviesListScene(with router: any MovieListRouter) -> Scene? {
    guard let moviesInteractor = try? container.resolve(.Domain.Interactor.movies) ,
          let analyticsManager = try? container.resolve(.Domain.Interactor.analytics) else {
      assertionFailure("Failed to resolve dependencies at \(#function)")
      return nil
    }
    return MoviesListScene(
      moviesInteractor: moviesInteractor,
      analyticsManager: analyticsManager,
      router: router)
  }
  
  func makeMovieDetailsRouter(for movie: Movie, navigationController: UINavigationController) -> any MovieDetailsRouter
  {
    let composer = MovieDetailsComposer(container: container)
    return composer.makeMovieDetailsRouter(for: movie, navigationController: navigationController)
  }
}
