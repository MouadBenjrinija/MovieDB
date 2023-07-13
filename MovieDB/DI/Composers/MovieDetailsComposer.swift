//
//  MovieDetailsComposer.swift
//  MovieDB
//
//  Created by Mouad Bj on 13/7/2023.
//

import UIKit
import MovieDBCore
import MovieDBUI


class MovieDetailsComposer: MovieDetailsDependencyFactory {
  private let container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
  }
  
  func makeMovieDetailsScene(for movie: Movie, router: some MovieDetailsRouter) -> Scene? {
    guard let moviesRepository = try? container.resolve(.Data.Repository.Remote.movies) else {
      assertionFailure("Failed to resolve dependencies at \(#function)")
      return nil
    }
    return MovieDetailsScene(
      repository: moviesRepository,
      movie: movie,
      router: router)
  }
  
  func makeMovieDetailsRouter(for movie: Movie,
                              navigationController: UINavigationController) -> any MovieDetailsRouter {
    return MovieDetailsRouterMain(
      movie: movie,
      navigationController: navigationController,
      dependencyFactory: self)
  }
  
  deinit {
    print("MovieDetailsComposer cleared")
  }
}
