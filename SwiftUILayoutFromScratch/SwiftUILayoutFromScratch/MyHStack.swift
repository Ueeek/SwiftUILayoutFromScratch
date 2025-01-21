//
//  MyHStack.swift
//  SwiftUILayoutFromScratch
//
//  Created by KoichiroUeki on 2025/01/21.
//

import SwiftUI

struct MyHStack: Layout {
    var alignment: VerticalAlignment = .center
    var spacing: CGFloat = .zero
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let viewFrames = frames(for: subviews, in: proposal)
        let height = viewFrames.max { $0.height < $1.height }?.height ?? .zero
        let width = viewFrames.reduce(0) { $0 + $1.width } + CGFloat(subviews.count - 1) * spacing
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal proposedViewSize: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let viewFrames = frames(for: subviews, in: proposedViewSize)
        
        for index in subviews.indices {
            let frame = viewFrames[index]
            
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
    enum WidthType {
        case flex
        case fixed
    }
    
    // Everyview can have their ideal width.
    func getWidthForFlexParentView(with subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGFloat] {
        return subviews.map {
            $0.sizeThatFits(.unspecified).width
        }
    }
    
    // There is limitation of width.
    func getWidthForFixedParentView(with subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGFloat] {
        assert(proposedViewSize.width != nil)
        
        // Check there is enough width other than `spacing`.
        let totalSpacing = spacing * Double(subviews.count - 1)
        let availableWidthWithoutSpace: CGFloat = proposedViewSize.width! - totalSpacing
        
        /// Not enough space for display any view.
        if availableWidthWithoutSpace <= 0 {
            return subviews.map { _ in .zero }
        }
        
        // Check there is enough width for fixed views.
        let viewTypes: [WidthType] = subviews.map {
            if $0.sizeThatFits(.infinity).width == .infinity {
                .flex
            } else {
                .fixed
            }
        }
        
        let totalWidthForFixedViews: CGFloat = zip(viewTypes, subviews).filter { type, subView in
            type == .fixed
        }.map {
            $1
        }.reduce(0.0) {
            $0 + $1.sizeThatFits(.unspecified).width
        }
        
        let remainingWidthForFlexViews = availableWidthWithoutSpace - totalWidthForFixedViews
        
        /* Not enough space for fixed-size views.
         + .fixed: compromise width
         + .flex: .zero
         */
        if remainingWidthForFlexViews < 0 {
            let fixedViews = viewTypes.filter { $0 == .fixed }.count
            let compromisedWidthForFixedView = availableWidthWithoutSpace / CGFloat(fixedViews)
            return zip(viewTypes, subviews).map { type, subview in
                if type == .fixed {
                    let newProposedSize = ProposedViewSize(width: compromisedWidthForFixedView, height: proposedViewSize.height)
                    return subview.sizeThatFits(newProposedSize).width
                } else {
                    return CGFloat.zero
                }
            }
        }
        
        let dynamicViews = viewTypes.filter { $0 == .flex }.count
        let dynamicWidth: CGFloat = remainingWidthForFlexViews / CGFloat(dynamicViews)
        return zip(viewTypes, subviews).map { type, subview in
            if type == .fixed {
                return subview.sizeThatFits(proposedViewSize).width
            } else {
                return dynamicWidth
            }
        }
    }
    
    func frames(for subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGRect] {
        let parentViewWidthType: WidthType = proposedViewSize.width == nil ? .flex : .fixed
        
        let heights: [CGFloat] = {
            let filledProposal: ProposedViewSize = ProposedViewSize(proposedViewSize.replacingUnspecifiedDimensions())
            return subviews.map { $0.sizeThatFits(filledProposal).height}
        }()
        
        let widths = if parentViewWidthType == .flex {
            getWidthForFlexParentView(with: subviews, in: proposedViewSize)
        } else {
            getWidthForFixedParentView(with: subviews, in: proposedViewSize)
        }
        
        var x: CGFloat = .zero
        let totalSpacing = spacing * CGFloat(subviews.count - 1)
        let totalWidth: CGFloat = widths.reduce(0.0) { $0 + $1 } + totalSpacing
        return zip(heights, widths).map { h, w in
            CGSize(width: w, height: h)
        }.reduce(into: []) { list, size in
            let origin = CGPoint(x: -totalWidth/2 + x, y: .zero)
            let frame =  CGRect(origin: origin, size: size)
            x += size.width + spacing
            list.append(frame)
        }
    }
}

#Preview("ParentFrame not enough width") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Text("aaaaaa")
            Text("bbbbbbbbbbbbb")
        }.frame(width: 20)
            .foregroundColor(.red)
        MyHStack(spacing: 10) {
            Text("aaaaaa")
            Text("bbbbbbbbbbbbb")
        }.frame(width: 20)
            .foregroundColor(.yellow)
    }
}

#Preview("Text and Rectangle") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.red)
            Text("a")
            Rectangle().fill(.red)
        }
        MyHStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.green)
            Text("a")
            Rectangle().fill(.green)
        }
    }
}

#Preview("Text and Rectagnle in ScrollView") {
    VStack(spacing: 10) {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                Text("a")
                Rectangle().fill(.red)
                Text("a")
                Rectangle().fill(.red)
            }
        }
        
        ScrollView(.horizontal) {
            MyHStack(spacing: 10) {
                Text("a")
                Rectangle().fill(.green)
                Text("a")
                Rectangle().fill(.green)
            }
        }
    }
}

#Preview("Rectangle, but parent view has not enough width") {
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
}

#Preview("HStack with padding") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Rectangle().fill(.blue)
            Rectangle().fill(.red)
        }.padding(.horizontal, 100)
        
        MyHStack(spacing: 10) {
            Rectangle().fill(.yellow)
            Rectangle().fill(.green)
        }.padding(.horizontal, 100)
    }
}

#Preview("Hstack with spacing") {
    VStack(spacing: 10) {
        Text("Spacing: 0")
        HStack(spacing: 0) {
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
            Rectangle().frame(width: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(spacing: 0) {
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
        }
        
        Text("Spacing: 20")
        HStack(spacing: 20) {
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
            Rectangle().frame(width: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(spacing: 20) {
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
        }
    }
}

#Preview("Hstack with alignment") {
    VStack {
        Text("Top")
        HStack(alignment: .top, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(alignment: .top, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
        }
        
        Text("Center")
        HStack(alignment: .center, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(alignment: .center, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
        }
        
        Text("Bottom")
        HStack(alignment: .bottom, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.red)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.blue)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.red)
        }
        
        MyHStack(alignment: .bottom, spacing: 0) {
            Rectangle().frame(width: 30, height: 10).foregroundStyle(Color.yellow)
            Rectangle().frame(width: 50, height: 50).foregroundStyle(Color.green)
            Rectangle().frame(width: 30, height: 30).foregroundStyle(Color.yellow)
        }
    }
}

#Preview("Hstack with ScrollView") {
    VStack {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
                Rectangle().frame(width: 30).foregroundStyle(Color.red)
                Rectangle().frame(width: 50).foregroundStyle(Color.blue)
            }
        }
        
        ScrollView(.horizontal) {
            MyHStack(spacing: 0) {
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
                Rectangle().frame(width: 30).foregroundStyle(Color.yellow)
                Rectangle().frame(width: 50).foregroundStyle(Color.green)
            }
        }
    }
}
