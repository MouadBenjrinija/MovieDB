//
//  DIContainer+Config.swift
//  MovieDB
//
//  Created by Mouad Bj on 4/7/2023.
//

import Foundation
import MovieDBData
import MovieDBUI
import MovieDBCore
import MovieDBInfra

extension Instantiator {

  static var urlSession: Instantiator<URLSession> {
    .shared { _ in .default }
  }
  // MARK: DataSources
  static var networkManager: Instantiator<NetworkManager> {
    .shared { NetworkManagerMain(session: $0.get(.urlSession)) }
  }
  static var moviesRemoteDataSource: Instantiator<MoviesRemoteDataSource> {
    .shared { MoviesRemoteDataSourceMain(networkManager: $0.get(.networkManager)) }
  }
  static var remoteImageSource: Instantiator<RemoteImageSource> {
    .shared { RemoteImageSourceMain(networkManager: $0.get(.networkManager)) }
  }
  static var localImageSource: Instantiator<LocalImageSource> {
    .onDemand { _ in LocalImageSourceMemory() }
  }
  
  // MARK: Repositories
  static var moviesRepository: Instantiator<MoviesRepository> {
    .onDemand { MoviesRepositoryMain(remoteMovies: $0.get(.moviesRemoteDataSource)) }
  }
  static var imageRepository: Instantiator<ImageRepository> {
    .onDemand { ImageRepositoryMain(
      localImageSource: $0.get(.localImageSource),
      remoteImageSource: $0.get(.remoteImageSource))
    }
  }
  
  // MARK:  Domain Intractors
  static var movieInteractor: Instantiator<MoviesInteractor> {
    .shared { MovieInteractorMain(moviesRepository: $0.get(.moviesRepository)) }
  }
  
  // MARK:  Services
  static var analyticsService: Instantiator<AnalyticsService> {
    .singleton { _ in AnalyticsMainService() }
  }
}
