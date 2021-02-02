//
//  Stepper.swift
//  DEFlow
//
//  Created by DaEun Kim on 2021/02/01.
//

import Combine
import UIKit

enum Step {

}

protocol Stepper {
  var steps: PassthroughSubject<Step, Error> { get }
}
