//
//  Publisher.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import Foundation
import Combine

extension AnyPublisher {
  public func async() async throws -> Output {
    try await withCheckedThrowingContinuation { continuation in
      var cancellable: AnyCancellable?
      cancellable = first()
        .sink { result in
          switch result {
          case .finished:
            break
          case let .failure(error):
            continuation.resume(throwing: error)
          }
          cancellable?.cancel()
        } receiveValue: { value in
          continuation.resume(with: .success(value))
        }
    }
  }
}

public typealias DisposeBag = Set<AnyCancellable>
extension DisposeBag {
    public mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}
