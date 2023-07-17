//
//  MovieDetailsComposer.swift
//  MovieDB
//
//  Created by Mouad Bj on 13/7/2023.
//

import UIKit
import MovieDBCore
import MovieDBUI


class MovieDetailsComposer: MovieDetailsSceneFactory {
  private let container: DIContainer
  private weak var navigationController: UINavigationController?
  
  init(container: DIContainer, navigationController: UINavigationController) {
    self.container = container
    self.navigationController = navigationController
  }
  
  func makeMovieDetailsScene(for movie: Movie) -> Scene? {
    guard let navigationController,
          let moviesRepository = try? container.resolve(.Data.Repository.Remote.movies) else {
      assertionFailure("Failed to resolve dependencies at \(#function)")
      return nil
    }
    let router = MovieDetailsRouterMain(navigationController: navigationController, sceneFactory: self)
    return MovieDetailsScene(
      repository: moviesRepository,
      movie: movie,
      router: router)
  }
  
  deinit {
    print("MovieDetailsComposer cleared")
  }
}
