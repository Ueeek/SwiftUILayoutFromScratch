//
//  ContentView.swift
//  SwiftUILayoutFromScratch
//
//  Created by KoichiroUeki on 2025/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Rectangle().fill(.red)
                    .frame(width: 80)
                Rectangle().fill(.blue)
                    .frame(width: 50)
            }.frame(width: 100)
            
            MyHStack(spacing: 10) {
                MyHStack(spacing: 10) {
                    Rectangle().fill(.red)
                        .frame(width: 80)
                    Rectangle().fill(.blue)
                        .frame(width: 50)
                }.frame(width: 100)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
