//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by DaEun Kim on 2021/01/17.
//

import SwiftUI

struct ContentView: View {

  var colors: [Color] = [.black, .red, .green, .blue]
  var colornames = ["Black", "Red", "Green", "Blue"]

  @State private var colorIndex = 0
  @State private var rotation: Double = 0
  @State private var text = "Welcome to SwiftUI"

  var body: some View {
    VStack {
      Spacer()
      Text(text)
        .font(.largeTitle)
        .fontWeight(.heavy)
        .rotationEffect(.degrees(rotation))
        .animation(.easeInOut(duration: 5))
        .foregroundColor(colors[colorIndex])

      Divider()
      
      Spacer()
      Slider(value: $rotation, in: 0...360, step: 0.1)
        .padding()

      TextField("Enter text here", text: $text)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()

      Picker(selection: $colorIndex, label: Text("Color")) {
        ForEach (0..<colornames.count) {
          Text(colornames[$0])
            .foregroundColor(colors[$0])
        }
      }
      .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
