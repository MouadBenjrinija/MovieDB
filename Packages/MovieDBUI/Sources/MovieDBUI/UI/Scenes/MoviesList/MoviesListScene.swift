//
//  MoviesListScene.swift
//  
//
//  Created by Mouad Bj on 11/7/2023.
//

import UIKit
import MovieDBCore

// a Scene creates and glues the View and the ViewModel
// it doesn't create depdendencies, as they are passed through constructor (by the composer)
public class MoviesListScene {
  
  private let moviesListViewController: MoviesListViewController
  
  public init(moviesInteractor: MoviesInteractor,
       analyticsManager: AnalyticsService,
       router: some MovieListRouter)
  {
    let viewModel = MoviesListViewModel(
      moviesInteractor: moviesInteractor,
      analyticsManager: analyticsManager,
      router: router
    )
    moviesListViewController = MoviesListViewController.instantiateFromNib()
    moviesListViewController.viewModel = viewModel
  }
}

extension MoviesListScene: Scene {
  public var viewController: UIViewController { moviesListViewController }
}
