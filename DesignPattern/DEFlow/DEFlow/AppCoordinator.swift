//
//  AppCoordinator.swift
//  DEFlow
//
//  Created by DaEun Kim on 2021/02/01.
//

import Combine
import UIKit

final class NavigationController: UINavigationController, Stepper {
  let steps = PassthroughSubject<Step, Error>()
}

final class AppCoordinator: Coordinator {
  let root: Stepper = NavigationController()

  init() {
    root.steps.
  }
}
