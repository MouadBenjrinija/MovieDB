//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import Foundation
import MovieDBCore
import Combine

class MovieDetailsViewModel {
  
  private let repository: MoviesRepository
  private let movie: Movie
  private let router: any MovieDetailsRouter
  @Published private var movieDetails: Loadable<MovieDetails> = .notLoaded
  
  /// derived attributes
  var title: AnyPublisher<String, Never>!
  var description: AnyPublisher<String, Never>!
  var genres: AnyPublisher<String, Never>!
  var posterURL: AnyPublisher<URL?, Never>!
  var isLoading: AnyPublisher<Bool, Never>!
  
  init(repository: MoviesRepository, movie: Movie, router: any MovieDetailsRouter) {
    self.repository = repository
    self.movie = movie
    self.router = router
    setup()
  }
  
  func setup() {
    let movieDetailsPublisher = $movieDetails.map(\.value)
      .replaceError(with: nil)
      .compactMap { $0 }
      .receive(on: DispatchQueue.main)
    
    self.title = movieDetailsPublisher.map { $0.title }.eraseToAnyPublisher()
    self.description = movieDetailsPublisher.map { $0.overview ?? "-" }.eraseToAnyPublisher()
    self.genres = movieDetailsPublisher.map {
      $0.genres?.compactMap { $0.name }
        .joined(separator: ", ") ?? "-"
      }.eraseToAnyPublisher()
    self.posterURL = Just(repository.urlFor(posterPath: movie.posterPath)).eraseToAnyPublisher()
    self.isLoading = $movieDetails
      .map(\.isLoading)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  func loadDetails() {
    movieDetails = .loading(nil)
    Task {
      do {
        let result = try await repository.fetchMovieDetails(id: movie.id)
        movieDetails = .loaded(result)
      } catch(let error) {
        movieDetails = .failed(nil, error)
      }
    }
  }
  
  func didTapBackButton() {
    router.trigger(route: .goBack)
  }
  
  func didTapShowTrailerButton() {
    router.trigger(route: .showTrailer(movie))
  }
  
  deinit {
    print("MovieDetailsViewModel cleared")
  }
  
}
