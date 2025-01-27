//
//  MyStack_NotWorkingSame_Preview.swift
//  SwiftUILayoutFromScratch
//
//  Created by KoichiroUeki on 2025/01/27.
//

import Foundation
import SwiftUI

// MG Examples
#Preview("2 text") {
    VStack {
        HStack {
            Text("1234567")
                .border(.red)
            Text("ABCDEDG")
            Text("1234567")
                .border(.red)
            Text("ABCDEDG")
            Text("1234567")
                .border(.red)
        }.frame(width: 100)
        MyHStack {
            Text("1234567")
                .border(.red)
            Text("ABCDEDG")
            Text("1234567")
                .border(.red)
            Text("ABCDEDG")
            Text("1234567")
                .border(.red)
        }.frame(width: 100)
    }
}

#Preview("2 text with Spacer") {
    VStack {
        HStack {
            Text("1234567")
                .border(.red)
            Spacer()
            Text("ABCDEDG")
        }
        MyHStack {
            Text("1234567")
                .border(.red)
            Spacer()
            Text("ABCDEDG")
        }
    }
}

#Preview("2 text with Spacer and LayoutPriority") {
    VStack {
        HStack {
            Text("1234567")
                .lineLimit(1)
                .layoutPriority(1)
                .border(.red)
            Spacer()
            Text("ABCDEDG")
                .border(.blue)
                .lineLimit(1)
        }.frame(width: 150)
        MyHStack {
            Text("1234567")
                .lineLimit(1)
                .layoutPriority(1)
                .border(.red)
            Spacer()
            Text("ABCDEDG")
                .border(.blue)
                .lineLimit(1)
        }.frame(width: 150)
    }
}

#Preview("2 text with Spacer and LayoutPriority") {
    VStack {
        Text("Original HStack")
            .font(.title)
        HStack {
            Text("1234567")
                .lineLimit(1)
                .layoutPriority(1)
                .border(.red)
            Spacer()
            Text("ABCDEDG")
                .border(.blue)
                .lineLimit(1)
        }.frame(width: 150, height: 50)
        Text("My HStack")
            .font(.title)
        MyHStack {
            Text("1234567")
                .lineLimit(1)
                .layoutPriority(1)
                .border(.red)
            Spacer()
            Text("ABCDEDG")
                .border(.blue)
                .lineLimit(1)
        }.frame(width: 150, height: 50)
    }.frame(height: 50)
}

