//
//  MovieCellViewModel.swift
//  
//
//  Created by Mouad Bj on 11/7/2023.
//

import Foundation
import MovieDBCore

struct MovieCellViewModel: Hashable {
  let movie: Movie
  let posterURL: URL?
  var title: String { movie.title }
  var releaseDate: String {
    movie.releaseDate?.toString() ?? "-"
  }
  var rating: String {
    "⭐ \(Int(movie.voteAverage ?? 0))/100"
  }
}
