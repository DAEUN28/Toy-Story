//
//  Car.swift
//  ListNavDemo
//
//  Created by DaEun Kim on 2021/02/21.
//

import SwiftUI

struct Car: Codable, Identifiable {
  var id: String
  var name: String

  var description: String
  var isHybrid: Bool

  var imageName: String
}
