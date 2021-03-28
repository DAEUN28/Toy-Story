//
//  CarDetail.swift
//  ListNavDemo
//
//  Created by DaEun Kim on 2021/02/21.
//

import SwiftUI

struct CarDetail: View {

  let selectedCar: Car

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct CarDetail_Previews: PreviewProvider {
  static var previews: some View {
    CarDetail(selectedCar: carData[0])
  }
}
