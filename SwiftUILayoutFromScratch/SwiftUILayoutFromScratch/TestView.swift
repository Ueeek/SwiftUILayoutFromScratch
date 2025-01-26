//
//  TestView.swift
//  SwiftUILayoutFromScratch
//
//  Created by KoichiroUeki on 2025/01/25.
//

import Foundation
import SwiftUICore
import SwiftUI

struct TestLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        subviews.enumerated().map { (index, subview) in
            let zero = subview.sizeThatFits(.zero)
            let unspeficied = subview.sizeThatFits(.unspecified)
            let inf = subview.sizeThatFits(.infinity)
            let filled = subview.sizeThatFits(ProposedViewSize(proposal.replacingUnspecifiedDimensions()))
            let prio = subview.priority
            let cont = subview.containerValues
            let prop = subview.sizeThatFits(proposal)
            print("#\(index) zero: \(zero) unspecified: \(unspeficied) inf: \(inf) prop: \(prop) filled: \(filled) p: \(prio)")
        }
        
        return .zero
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    }
}

//#Preview {
//    TestLayout {
//        Text("Hello")
//        Text("Hello")
//            .frame(width: 100)
//        Text("Hello")
//            .frame(idealWidth: 100)
//        Text("Hello")
//            .frame(minWidth: 10)
//        Text("Hello")
//            .frame(maxWidth: 200)
//        Text("Hello")
//            .frame(minWidth: 10, maxWidth: 200)
//    }
//}
//#Preview ("Rect"){
//    TestLayout {
//        Rectangle()
//        Rectangle()
//            .frame(width: 100)
//        Rectangle()
//            .frame(idealWidth: 100)
//        Rectangle()
//            .frame(minWidth: 10)
//        Rectangle()
//            .frame(maxWidth: 200)
//        Rectangle()
//            .frame(minWidth: 10, maxWidth: 200)
//    }
//}
//
//#Preview("Spacer") {
//    TestLayout {
//        Spacer()
//        Spacer()
//            .frame(width: 100)
//        Spacer()
//            .frame(idealWidth: 100)
//        Spacer()
//            .frame(minWidth: 10)
//        Spacer()
//            .frame(maxWidth: 200)
//        Rectangle()
//            .frame(minWidth: 10, maxWidth: 200)
//    }
//}
//
//#Preview("Spacer and Rect") {
//    TestLayout {
//        Rectangle()
//        Spacer()
//        Rectangle()
//            .frame(minWidth: 8, idealWidth: 8, minHeight: 8, idealHeight: 8)
//    }
//}
//
//#Preview("Spacer and Rect") {
//    VStack {
//        Rectangle()
//            .fill(.blue)
//            .frame(minWidth: 8, idealWidth: 8, minHeight: 8, idealHeight: 8)
//        Spacer()
//        Rectangle()
//            .fill(.red)
//            .frame(minWidth: 8, idealWidth: 8, minHeight: 8, idealHeight: 8)
//    }
//}
//
#Preview {
    TestLayout {
        Text("hoge")
        Spacer()
        Rectangle()
    }
}

#Preview {
    HStack(spacing: 10) {
        //    TestLayout {
        Text("hoge")
//            .frame(minWidth: 200, maxWidth: 100)
            .border(.red)
        Text("hoge")
//            .frame(minWidth: 100, maxWidth: 200)
            .border(.red)
        Text("hoge")
//            .frame(minWidth: 100, maxWidth: 200)
            .border(.red)
    }
    .padding(.vertical, 40)
    .frame(maxWidth: .infinity)
//}.frame(maxWidth: 200)
        .border(.blue)
}
