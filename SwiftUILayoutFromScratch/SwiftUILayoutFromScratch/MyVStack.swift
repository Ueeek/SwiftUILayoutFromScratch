//
//  MyVStack.swift
//  SwiftUILayoutFromScratch
//
//  Created by KoichiroUeki on 2025/01/21.
//

//import SwiftUI
//
//struct MyVStack: Layout {
//    var alignment: HorizontalAlignment = .center
//    var spacing: CGFloat = .zero
//    
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let viewFrames = frames(for: subviews, in: proposal)
//        let width = viewFrames.max { $0.width < $1.width }?.width ?? .zero
//        let height = viewFrames.reduce(0) { $0 + $1.height } + CGFloat(subviews.count - 1) * spacing
//        return CGSize(width: width, height: height)
//    }
//    
//    func placeSubviews(in bounds: CGRect, proposal proposedViewSize: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        let viewFrames = frames(for: subviews, in: proposedViewSize)
//        
//        for index in subviews.indices {
//            let frame = viewFrames[index]
//            
//            let x = switch alignment {
//                case .leading:
//                    bounds.midX - bounds.width/2 + frame.width/2
//                case .center:
//                    bounds.midX
//                case .trailing:
//                    bounds.midX + bounds.width/2 - frame.width/2
//                default:
//                    bounds.midX
//            }
//            
//            let position = CGPoint(x: x, y: bounds.midY + frame.minY)
//            subviews[index].place(at: position, anchor: .top, proposal: ProposedViewSize(frame.size))
//        }
//    }
//    
//    func frames(for subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGRect] {
//        var viewFrames: [CGRect] = []
//        var y: CGFloat = .zero
//        
//        let totalHeight = subviews.reduce(0) { $0 + $1.sizeThatFits(proposedViewSize).height } + spacing * CGFloat(subviews.count - 1)
//        
//        for subview in subviews {
//            let size = subview.sizeThatFits(proposedViewSize)
//            let frame = CGRect(x: .zero, y: -totalHeight/2 + y, width: size.width, height: size.height)
//            viewFrames.append(frame)
//            y += size.height + spacing
//        }
//        return viewFrames
//    }
//}
//
//#Preview("Vstack with spacing") {
//    VStack {
//        Text("Spacing: 0")
//        HStack(spacing: 10) {
//            VStack(spacing: 0) {
//                Rectangle().frame(height: 30).foregroundStyle(Color.red)
//                Rectangle().frame(height: 50).foregroundStyle(Color.blue)
//                Rectangle().frame(height: 30).foregroundStyle(Color.red)
//            }
//            
//            MyVStack(spacing: 0) {
//                Rectangle().frame(height: 30).foregroundStyle(Color.yellow)
//                Rectangle().frame(height: 50).foregroundStyle(Color.green)
//                Rectangle().frame(height: 30).foregroundStyle(Color.yellow)
//            }
//        }
//        
//        Text("Spacing: 20")
//        HStack {
//            VStack(spacing: 20) {
//                Rectangle().frame(height: 30).foregroundStyle(Color.red)
//                Rectangle().frame(height: 50).foregroundStyle(Color.blue)
//                Rectangle().frame(height: 30).foregroundStyle(Color.red)
//            }
//            
//            MyVStack(spacing: 20) {
//                Rectangle().frame(height: 30).foregroundStyle(Color.yellow)
//                Rectangle().frame(height: 50).foregroundStyle(Color.green)
//                Rectangle().frame(height: 30).foregroundStyle(Color.yellow)
//            }
//        }
//    }
//}
//
//#Preview("VStack with alignment") {
//    VStack {
//        Text("Leading")
//        HStack {
//            VStack(alignment: .leading, spacing: 0) {
//                Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
//                Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
//                Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
//            }
//            
//            MyVStack(alignment: .leading, spacing: 0) {
//                Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
//                Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
//                Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
//            }
//        }
//        
//        Text("Center")
//        HStack {
//            VStack(alignment: .center, spacing: 0) {
//                Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
//                Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
//                Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
//            }
//            
//            MyVStack(alignment: .center, spacing: 0) {
//                Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
//                Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
//                Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
//            }
//        }
//        
//        Text("Trailing")
//        HStack {
//            VStack(alignment: .trailing, spacing: 0) {
//                Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
//                Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
//                Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
//            }
//            
//            MyVStack(alignment: .trailing, spacing: 0) {
//                Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
//                Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
//                Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
//            }
//        }
//    }
//}
//
//#Preview("VStack in ScrollView") {
//    VStack {
//        HStack {
//            ScrollView(.vertical) {
//                VStack(spacing: 0) {
//                    Rectangle().frame(width: 30).foregroundStyle(Color.red)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.blue)
//                    Rectangle().frame(width: 30).foregroundStyle(Color.red)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.blue)
//                    Rectangle().frame(width: 30).foregroundStyle(Color.red)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.blue)
//                    Rectangle().frame(width: 30).foregroundStyle(Color.red)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.blue)
//                }
//            }
//            
//            ScrollView(.vertical) {
//                MyVStack(spacing: 0) {
//                    Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.green)
//                    Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.green)
//                    Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.green)
//                    Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
//                    Rectangle().frame(width: 50).foregroundStyle(Color.green)
//                }
//            }
//        }
//    }
//}
