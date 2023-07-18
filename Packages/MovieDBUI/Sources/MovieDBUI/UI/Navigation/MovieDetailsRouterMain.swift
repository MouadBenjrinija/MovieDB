//
//  File.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import UIKit
import MovieDBCore

public protocol MovieDetailsSceneFactory: AnyObject {
  func makeTrailerScene(for movie: Movie) -> Scene?
}

public class MovieDetailsRouterMain: MovieDetailsRouter {
  
  private weak var navigationController: UINavigationController?
  private let sceneFactory: MovieDetailsSceneFactory
  
  public init(navigationController: UINavigationController,
              sceneFactory: MovieDetailsSceneFactory) {
    self.navigationController = navigationController
    self.sceneFactory = sceneFactory
  }
  
  public func trigger(route: MovieDetailsRoute) {
    switch route {
    case .showTrailer(let movie): showTrailer(for: movie)
    case .goBack: popScene()
    }
  }
  
  private func popScene() {
    guard let navigationController else {
      assertionFailure("NavController not retained at \(#function)")
      return
    }
    navigationController.popViewController(animated: true)
  }
  
  private func showTrailer(for movie: Movie) {
    guard let scene = sceneFactory.makeTrailerScene(for: movie) else {
      assertionFailure("NavController not retained at \(#function)")
      return
    }
    scene.viewController.modalPresentationStyle = .formSheet
    navigationController?.present(scene.viewController, animated: true)
  }
  
  deinit {
    print("MovieDetailsRouterMain cleared")
  }
  
}
