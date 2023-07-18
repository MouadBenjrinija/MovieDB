//
//  MovieTrailerViewModel.swift
//  
//
//  Created by Mouad Bj on 17/7/2023.
//

import Foundation

public class MovieTrailerViewModel {
 
  let router: any MovieTrailerRouter

  init(router: any MovieTrailerRouter) {
    self.router = router
  }
  
}
