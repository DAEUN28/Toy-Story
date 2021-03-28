//
//  CarStore.swift
//  ListNavDemo
//
//  Created by DaEun Kim on 2021/02/21.
//

import SwiftUI
import Combine

class CarStore: ObservableObject {
  @Published var cars: [Car]

  init(cars: [Car] = []) {
    self.cars = cars
  }
}
