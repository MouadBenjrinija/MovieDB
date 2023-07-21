//
//  MovieDetailsComposer.swift
//  MovieDB
//
//  Created by Mouad Bj on 13/7/2023.
//

import UIKit
import MovieDBCore
import MovieDBUI


class MovieDetailsComposer {
  private let container: Container
  private weak var navigationController: UINavigationController?
  
  init(container: Container, navigationController: UINavigationController) {
    self.container = container
    self.navigationController = navigationController
  }
  
  func makeMovieDetailsScene(for movie: Movie) -> Scene? {
    guard let navigationController else {
      assertionFailure("navigationController not retained at \(#function)")
      return nil
    }
    let moviesRepository = container.get(.moviesRepository)
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

extension MovieDetailsComposer: MovieDetailsSceneFactory {
  func makeTrailerScene(for movie: Movie) -> Scene? {
    let composer = MovieTrailerComposer(container: container)
    return composer.makeTrailerScene(for: movie)
  }
}
