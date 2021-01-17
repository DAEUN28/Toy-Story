//
//  ObservableDemoApp.swift
//  ObservableDemo
//
//  Created by DaEun Kim on 2021/01/17.
//

import SwiftUI

@main
struct ObservableDemoApp: App {
  let timerData = TimerData()

  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(timerData)
    }
  }
}
