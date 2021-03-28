//
//  ContentView.swift
//  ListNavDemo
//
//  Created by DaEun Kim on 2021/02/21.
//

import SwiftUI

struct ContentView: View {

  @ObservedObject var carStore = CarStore(cars: carData)

  var body: some View {
    List {
      ForEach(carStore.cars) { car in
        ListCell(car: car)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct ListCell: View {
  var car: Car

  var body: some View {
    HStack {
      Image(car.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 60)
      Text(car.name)
    }
  }
}
