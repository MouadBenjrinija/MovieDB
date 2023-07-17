//
//  File.swift
//  
//
//  Created by Mouad Bj on 12/7/2023.
//

import Foundation
import MovieDBCore

public enum MovieDetailsRoute: Route {
  case goBack
}

public protocol MovieDetailsRouter: Router where RouteModel == MovieDetailsRoute {}
