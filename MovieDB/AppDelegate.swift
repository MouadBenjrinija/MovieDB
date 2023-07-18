//
//  AppDelegate.swift
//  MovieDB
//
//  Created by MOUAD BENJRINIJA on 14/3/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    // FLOW EXPLAINED:
    // > appdelegate create a composer > composer creates router (passing self)
    // > router owns the composer > router asks composer to create the scene
    // > composer creates the scene (the latter is just another composer for UI elements)
    //   passing the router instance to the viewModel and the latter to the viewcontroller
    // > viewModel owns the router > and the viewController owns the viewModel
    
    // ownership graph
    //  [appDelegate]->[window]->[navigationController]->[viewController]->[viewModel]->[router]->[composer]->[di-container]
    
    // responsibilities:
    // [viewController] manages user UI input/output
    // [viewModel] coordinates between the V and M of MVVM (keeps V synced to M + inform M of V input)
    // [router] defines what happens for what RoutingEvent + manages framework navigation (UINavigationController)
    // [composer] creates concrete components on demand for the router utilizing the di-container
    // [di-container] in this case works as a serviceLocator and is used only by composers.
    
    // why is the ownership like this? >> because when the viewController is poped from the navigationController, everythign related to that scene is deallocated along with it.
    
    let navigationController = UINavigationController()
    let mainComposer = MainComposer(
      container: DIContainer.configure(),
      navigationController: navigationController)
    let mainRouter = mainComposer.makeMainRouter()
    mainRouter.trigger(route: .moviesList)
    
    window!.rootViewController = navigationController
    window!.makeKeyAndVisible()
    
    return true
  }


}

