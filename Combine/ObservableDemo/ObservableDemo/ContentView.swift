//
//  ContentView.swift
//  ObservableDemo
//
//  Created by DaEun Kim on 2021/01/17.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var timerData: TimerData

  var body: some View {
    NavigationView {
      VStack {
        Text("Timer count = \(timerData.timeCount)")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding()

        Button(action: resetCount, label: {
          Text("Reset Counter")
        })

        NavigationLink(
          destination: SecondView(),
          label: {
            Text("Next Screen")
          })
          .padding()
      }
    }
  }

  func resetCount() {
    timerData.resetCount()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(TimerData())
  }
}
