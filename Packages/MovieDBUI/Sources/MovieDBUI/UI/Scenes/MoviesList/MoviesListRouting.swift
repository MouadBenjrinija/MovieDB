//
//  MoviesListRouting.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import Foundation
import MovieDBCore

public enum MoviesListRoute: Route {
  case goToDetails(Movie)
}

public protocol MovieListRouter: Router where AnyRoute == MoviesListRoute {}
