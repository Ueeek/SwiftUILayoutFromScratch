//
//  ContentView.swift
//  SwiftUILayoutFromScratch
//
//  Created by KoichiroUeki on 2025/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MyVStack {
            MyHStack {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 50, height: 50)
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            MyHStack(spacing: 0) {
                Rectangle().fill(.red)
                Text("Text4")
            }
            
            HStack(spacing: 0) {
                Rectangle().fill(.red)
                Text("Text4")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
