//
//  MovieTrailerComposer.swift
//  MovieDB
//
//  Created by Mouad Bj on 17/7/2023.
//

import UIKit
import MovieDBCore
import MovieDBUI

class MovieTrailerComposer {
  private let container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
  }
  
  func makeTrailerScene(for movie: Movie) -> Scene? {
    let router = MovieTrailerRouterMain(sceneFactory: self)
    return MovieTrailerScene(router: router)
  }
  
  deinit {
    print("MovieTrailerComposer cleared")
  }
}

extension MovieTrailerComposer: MovieTrailerSceneFactory {
  
}
