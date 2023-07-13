//
//  MovieDetailsScene.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import UIKit
import MovieDBCore

// a Scene creates and glues the View and the ViewModel
// it doesn't create depdendencies, as they are passed through constructor (by the composer)
public class MovieDetailsScene {
  
  private let movieDetailsViewController: MovieDetailsViewController
  
  public init(repository: MoviesRepository,
              movie: Movie,
              router: some MovieDetailsRouter)
  {
    let viewModel = MovieDetailsViewModel(
      repository: repository,
      movie: movie,
      router: router
    )
    movieDetailsViewController = MovieDetailsViewController.instantiateFromNib()
    movieDetailsViewController.viewModel = viewModel
  }
  
  deinit {
    print("MovieDetailsScene cleared")
  }
  
}

extension MovieDetailsScene: Scene {
  public var viewController: UIViewController { movieDetailsViewController }
}
