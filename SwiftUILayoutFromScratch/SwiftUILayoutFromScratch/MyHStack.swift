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
    enum WidthType {
        case flex
        case fixed
    }
    
    // Each Child View can have their ideal width.
    func getSizeForFlexWidthParentView(with subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGSize] {
        print("### \(#function)")
        return subviews.map {
            $0.sizeThatFits(proposedViewSize)
        }
    }
    
    // There is limitation of width.
    func getSizeForFixedWidthParentView(with subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGSize] {
        assert(proposedViewSize.width != nil)
        print("### \(#function)")
        
        // Check there is enough width other than `spacing`.
        let totalSpacing = spacing * Double(subviews.count - 1)
        let availableWidthWithoutSpace: CGFloat = proposedViewSize.width! - totalSpacing
        print("# availableWidthWithoutSpace: \(availableWidthWithoutSpace)")
        
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
        let hViewTypes: [WidthType] = subviews.map {
            if $0.sizeThatFits(.infinity).height == .infinity {
                .flex
            } else {
                .fixed
            }
        }
        let priorities = subviews.map { $0.priority }
        print("# viewTypes: \(viewTypes)")
        print("# hViewTypes: \(hViewTypes)")
        print("# priorities: \(priorities)")

        let totalWidthForFixedViews: CGFloat = zip(viewTypes, subviews).filter { type, subView in
            type == .fixed
        }.map {
            $1
        }.reduce(0.0) {
            $0 + $1.sizeThatFits(.infinity).width
        }
        print("# totalWidthForFixedViews: \(totalWidthForFixedViews)")
        
        let remainingWidthForFlexViews = availableWidthWithoutSpace - totalWidthForFixedViews
        print("# remainingWidthForFlexViews: \(remainingWidthForFlexViews)")
        
        /* Not enough space for fixed-size views.
         + .fixed: compromise width
         + .flex: .zero
         */
        if remainingWidthForFlexViews < 0 {
            let fixedViews = viewTypes.filter { $0 == .fixed }.count
            let compromisedWidthForFixedView = availableWidthWithoutSpace / CGFloat(fixedViews)
            return zip(viewTypes, subviews).map { type, subview in
                // Behavior Difference
                if type == .fixed {
                    let newProposedSize = ProposedViewSize(width: compromisedWidthForFixedView, height: proposedViewSize.height)
                    return subview.sizeThatFits(newProposedSize)
                } else {
                    return CGSize.zero
                }
            }
        }
        
        let dynamicViews = viewTypes.filter { $0 == .flex }.count
        let dynamicWidth: CGFloat = if dynamicViews > 0 {
            remainingWidthForFlexViews / CGFloat(dynamicViews)
        } else {
            .zero
        }
        print("# dynamicWidth: \(dynamicWidth)")
        return zip(viewTypes, subviews).map { type, subview in
            if type == .fixed {
                print("# proposedViewSize \(proposedViewSize)")
                return subview.sizeThatFits(proposedViewSize)
            } else {
                let proposedSize = ProposedViewSize(width: dynamicWidth, height: proposedViewSize.height)
                return subview.sizeThatFits(proposedSize)
            }
        }
    }
    
    func frames(for subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGRect] {
        let parentViewWidthType: WidthType = proposedViewSize.width == nil ? .flex : .fixed
        
        let sizes = if parentViewWidthType == .flex {
            getSizeForFlexWidthParentView(with: subviews, in: proposedViewSize)
        } else {
            getSizeForFixedWidthParentView(with: subviews, in: proposedViewSize)
        }
        print("# widths: \(sizes.map { $0.width })")
        print("# heights: \(sizes.map { $0.height })")
        
        var x: CGFloat = .zero
        let totalSpacing = spacing * CGFloat(subviews.count - 1)
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
                .lineLimit(1)
        }.frame(width: 150)
        MyHStack {
            Text("1234567")
                .lineLimit(1)
                .layoutPriority(1)
                .border(.red)
            Spacer()
            Text("ABCDEDG")
                .lineLimit(1)
        }.frame(width: 150)
    }
}

#Preview("with min width") {
    VStack {
        HStack {
            Rectangle()
                .fill(.red)
                .frame(minWidth: 100)
            Rectangle()
                .fill(.blue)
                .frame(minWidth: 100, maxWidth: 250)
        }.frame(width: 400)
        MyHStack {
            Rectangle()
                .fill(.green)
                .frame(minWidth: 100)
            Rectangle()
                .fill(.yellow)
                .frame(minWidth: 100, maxWidth: 250)
        }.frame(width: 400)
    }
}

