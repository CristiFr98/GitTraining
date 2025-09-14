//
//  ContentView.swift
//  GitTraining
//
//  Created by Cristi on 14.09.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("Title")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(Color.red)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Click me") {
                // some action
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
