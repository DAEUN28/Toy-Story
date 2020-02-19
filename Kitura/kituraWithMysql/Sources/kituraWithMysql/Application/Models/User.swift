import Foundation

import KituraContracts

struct Name: Codable {
  let name: String
}

struct ID: Codable {
  let id: Int
}

struct IDQuery: QueryParams {
  let id: Int
}
