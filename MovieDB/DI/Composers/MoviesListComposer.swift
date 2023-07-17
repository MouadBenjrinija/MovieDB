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
// a composer is responsiple of building dependencies and injecting them in different components
// it uses the DI container (service locator in this case) to resolve dependencies
class MoviesListComposer {
  
  private let container: DIContainer
  private weak var navigationController: UINavigationController?
  
  init(container: DIContainer, navigationController: UINavigationController) {
    self.container = container
    self.navigationController = navigationController
  }
  
  func makeMoviesListScene() -> Scene? {
    guard let navigationController,
          let moviesInteractor = try? container.resolve(.Domain.Interactor.movies) ,
          let analyticsManager = try? container.resolve(.Domain.Interactor.analytics) else {
      assertionFailure("Failed to start app at \(#function)")
      return nil
    }
    let router = MoviesListRouterMain(
      navigationController: navigationController,
      sceneFactory: self)
    return MoviesListScene(
      moviesInteractor: moviesInteractor,
      analyticsManager: analyticsManager,
      router: router) 
  }
}

extension MoviesListComposer: MoviesListSceneFactory {
  
  func makeMovieDetailsScene(for movie: Movie) -> Scene? {
    guard let navigationController else {
      assertionFailure("Failed to make MovieDetailsScene at \(#function)")
      return nil
    }
    let composer = MovieDetailsComposer(container: container, navigationController: navigationController)
    return composer.makeMovieDetailsScene(for: movie)
  }
}
