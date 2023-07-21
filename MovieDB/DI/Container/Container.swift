//
//  Container.swift
//  MovieDB
//
//  Created by Mouad Bj on 20/7/2023.
//

import Foundation

public class Container {
  
  static var shared = Container()
  
  private var storage: [ObjectIdentifier: any InjectionBox] = [:]
  
  func get<T>(_ instantiator: Instantiator<T>) -> T {
    switch instantiator.strategy {
    case .onDemand: return onDemand(using: instantiator)
    case .singleton: return singleton(using: instantiator)
    case .shared: return shared(using: instantiator)
    }
  }

  private func onDemand<T>(using instantiator: Instantiator<T>) -> T {
    return instantiator.make(self)
  }
  
  private func singleton<T>(using instantiator: Instantiator<T>) -> T {
    let identifier = ObjectIdentifier(T.self)
    if let instance = storage[identifier] as? StrongBox<T>,
       let value = instance.value
    {
      return value
    }
    let new = instantiator.make(self)
    storage[identifier] = StrongBox(value: new)
    return new
  }
  
  private func shared<T>(using instantiator: Instantiator<T>) -> T {
    let identifier = ObjectIdentifier(T.self)
    if let instance = storage[identifier] as? WeakBox<AnyObject>,
       let value = instance.value as? T
    {
      return value
    }
    let new = instantiator.make(self)
    if new is AnyClass {
      storage[identifier] = WeakBox(value: new as AnyObject)
    } else {
      assertionFailure("shared instances should be a class type")
    }
    return new
  }
  
}

public struct Instantiator<T> {
  
  public enum Strategy {
    case singleton
    case shared
    case onDemand
  }
  let strategy: Strategy
  let make: (Container) -> T
  init(strategy: Strategy, closure: @escaping (Container) -> T) {
    self.strategy = strategy
    self.make = closure
  }
  
  public static func singleton<T>(_ closure: @escaping (Container) -> T) -> Instantiator<T> {
    .init(strategy: .singleton, closure: closure)
  }
  
  public static func shared<T>(_ closure: @escaping (Container) -> T) -> Instantiator<T> {
    .init(strategy: .shared, closure: closure)
  }
  
  public static func onDemand<T>(_ closure: @escaping (Container) -> T) -> Instantiator<T> {
    .init(strategy: .onDemand, closure: closure)
  }
}

protocol InjectionBox {
  associatedtype Value
  var value: Value? { get set }
}

class WeakBox<T: AnyObject>: InjectionBox {
  weak var value: T?
  init(value: T) {
    self.value = value
  }
}

class StrongBox<T>: InjectionBox {
  var value: T?
  init(value: T) {
    self.value = value
  }
}


@propertyWrapper public final class Inject<T> {
  
  let instantiator: Instantiator<T>
  let container: Container = .shared
  var localInstance: T?
  
  public var wrappedValue: T {
    get {
      if let localInstance {
        return localInstance
      }
      localInstance = container.get(instantiator)
      return localInstance!
    }
  }
  
  public init(_ instantiator: Instantiator<T>) {
    self.instantiator = instantiator
  }
}

