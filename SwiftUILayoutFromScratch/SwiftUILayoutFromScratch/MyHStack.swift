//
//  MyHStack.swift
//  SwiftUILayoutFromScratch
//
//  Created by KoichiroUeki on 2025/01/21.
//

import SwiftUI

struct MyHStack: Layout {
    var alignment: VerticalAlignment = .center
    var spacing: CGFloat = 10
    
    // Return CGSize of container view.
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let viewFrames = frames(for: subviews, in: proposal)
        let maxHeight = viewFrames.max { $0.height < $1.height }?.height ?? .zero
        let totalWidth = viewFrames.reduce(0) { $0 + $1.width } + CGFloat(viewFrames.count - 1) * spacing
        return CGSize(width: totalWidth, height: maxHeight)
    }
    
    // Place each subview in the container view.
    func placeSubviews(in bounds: CGRect, proposal proposedViewSize: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let viewFrames = frames(for: subviews, in: proposedViewSize)
        
        for index in subviews.indices {
            let frame = viewFrames[index]
            // Adjust Y-position for `alignment`.
            let y = switch alignment {
                case .bottom:
                    bounds.midY + bounds.height/2 - frame.height/2
                case .center:
                    bounds.midY
                case .top:
                    bounds.midY - bounds.height/2 + frame.height/2
                default:
                    bounds.midY
            }
            
            let position = CGPoint(x: bounds.midX + frame.minX , y: y)
            subviews[index].place(at: position, anchor: .leading, proposal: ProposedViewSize(frame.size))
        }
    }
}

private extension MyHStack {
    // Parent view doesn't have fixed width. (e.g. HStack in ScrollView)
    // Each Child View can have their ideal width.
    func getSizeForFlexWidthParentView(with subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGSize] {
        subviews.map { $0.sizeThatFits(proposedViewSize) }
    }
    
    // Parent view has fixed width. (e.g. `HStack.frame(width: 100)`)
    // There is limitation of width.
    func getSizeForFixedWidthParentView(with subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGSize] {
        assert(proposedViewSize.width != nil)
        
        let heightLimit = proposedViewSize.height
        let widthLimit = proposedViewSize.width!
        
        
        // Try to fit with min sizes.
        let minSizes = subviews.map { $0.sizeThatFits(.zero) }
        let minWidths = minSizes.map { $0.width }
        let totalMinWidth = minSizes.reduce(0.0) { $0 + $1.width }
        
        var remainingWidth = widthLimit - totalMinWidth - CGFloat(subviews.count - 1) * spacing
        if remainingWidth < 0 {
            // Not enough space for min sizes. -> All view takes their min-size.
            return zip(minWidths, subviews).map { width, subview in
                subview.sizeThatFits(ProposedViewSize(width: width, height: heightLimit))
            }
        } else {
            // Expand to fill remaining spaces.
            var viewSizes = zip(minWidths, subviews).map { width, subview in
                subview.sizeThatFits(ProposedViewSize(width: width, height: heightLimit))
            }
            
            // Expand views from high priority one to low priority one.
            
            /// HighPriority -> LowPriority
            let sortedPriorities: [Double] = subviews
                .map { $0.priority }
                .reduce(into: Set<Double>.init()) { set, priority in
                    set.insert(priority)
                }.sorted { $0 > $1 }
            
            for targetPriority in sortedPriorities {
                // filter views which has the `targetPriority` and can expand
                var targetViewIndexs: Set<Int> = []
                for ((index, subview), minWidth) in zip(subviews.enumerated(), minWidths) {
                    guard subview.priority == targetPriority else { continue }
                    let canExpand = subview.sizeThatFits(.infinity).width > minWidth
                    if canExpand {
                        targetViewIndexs.insert(index)
                    }
                }
                
                /// Distribute remaining space to expandableHighPriorityViews
                while !targetViewIndexs.isEmpty && remainingWidth > 0 {
                    let distributeWidth = remainingWidth / CGFloat(targetViewIndexs.count)
                    for index in targetViewIndexs {
                        let subview = subviews[index]
                        let tempWidth = viewSizes[index].width
                        let newSize = subview.sizeThatFits(ProposedViewSize(width: tempWidth + distributeWidth, height: heightLimit))
                        
                        // Can expand -> Adjust again in next loop.
                        if newSize.width > tempWidth {
                            viewSizes[index] = newSize
                            remainingWidth -= (newSize.width - tempWidth)
                        } else { // Cannot expand -> No longer need to adjust.
                            targetViewIndexs.remove(index)
                        }
                    }
                }
            }
            return viewSizes
        }
    }
    
    func frames(for subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGRect] {
        let sizes: [CGSize] = if proposedViewSize.width == nil {
            getSizeForFlexWidthParentView(with: subviews, in: proposedViewSize)
        } else {
            getSizeForFixedWidthParentView(with: subviews, in: proposedViewSize)
        }
        
        var x: CGFloat = .zero
        let totalSpacing = spacing * CGFloat(sizes.count - 1)
        let totalWidth: CGFloat = sizes.map { $0.width }.reduce(0.0) { $0 + $1 } + totalSpacing
        
        return sizes.reduce(into: []) { list, size in
            let origin = CGPoint(x: -totalWidth/2 + x, y: .zero)
            let frame =  CGRect(origin: origin, size: size)
            x += size.width + spacing
            list.append(frame)
        }
    }
}

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

