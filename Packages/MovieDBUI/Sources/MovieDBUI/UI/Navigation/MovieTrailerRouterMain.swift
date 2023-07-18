//
//  MovieTrailerRouterMain.swift
//  
//
//  Created by Mouad Bj on 17/7/2023.
//

import Foundation

public protocol MovieTrailerSceneFactory: AnyObject {
}

public class MovieTrailerRouterMain: MovieTrailerRouter {
  
  private weak var sceneFactory: MovieTrailerSceneFactory?
  
  public init(sceneFactory: MovieTrailerSceneFactory) {
    self.sceneFactory = sceneFactory
  }
  
  public func trigger(route: MovieTrailerRoute) {
    
  }
  
}
