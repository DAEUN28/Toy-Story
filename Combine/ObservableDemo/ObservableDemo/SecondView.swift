//
//  SecondView.swift
//  ObservableDemo
//
//  Created by DaEun Kim on 2021/01/17.
//

import SwiftUI

struct SecondView: View {

  @EnvironmentObject var timerData: TimerData

  var body: some View {
    VStack {
      Text("Second View")
        .font(.largeTitle)
      Text("Timer Count = \(timerData.timeCount)")
        .font(.headline)
    }
    .padding()
  }
}

struct SecondView_Previews: PreviewProvider {
  static var previews: some View {
    SecondView().environmentObject(TimerData())
  }
}
