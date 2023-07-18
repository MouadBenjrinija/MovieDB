//
//  MovieTrailerScene.swift
//  
//
//  Created by Mouad Bj on 17/7/2023.
//

import UIKit

public class MovieTrailerScene {
  
  private let movieTrailerViewController: MovieTrailerViewController
  
  public init(router: some MovieTrailerRouter)
  {
    let viewModel = MovieTrailerViewModel(router: router)
    movieTrailerViewController = MovieTrailerViewController.instantiateFromNib()
    movieTrailerViewController.viewModel = viewModel
  }
}

extension MovieTrailerScene: Scene {
  public var viewController: UIViewController { movieTrailerViewController }
}
