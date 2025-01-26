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
        let width = viewFrames.reduce(0) { $0 + $1.width } + CGFloat(viewFrames.filter { $0.width > 0 }.count - 1) * spacing
        print("# width \(width)")
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal proposedViewSize: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let viewFrames = frames(for: subviews, in: proposedViewSize)
        print("# viewFrames \(viewFrames)")
        
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
        let highestPriority = subviews.map { $0.priority }.max() ?? .zero
        let sizes = subviews
            .enumerated()
            .sorted { $0.element.priority > $1.element.priority }
            .map { index, subview in
                if subview.priority == highestPriority {
                    (index, subview.sizeThatFits(proposedViewSize))
                } else {
                    (index, subview.sizeThatFits(.zero))
                }
            }.sorted { $0.0 < $1.0 }
            .map { $0.1 }
        return sizes
    }
    
    // There is limitation of width.
    func getSizeForFixedWidthParentView(with subviews: Subviews, in proposedViewSize: ProposedViewSize) -> [CGSize] {
        assert(proposedViewSize.width != nil)
        print("### \(#function)")
        print("# totalAvailableWidth \(proposedViewSize.width)")
        
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
        let priorities = zip(viewTypes, subviews)
            .filter { viewType, subview in
                viewType == .flex
            }.map {
                $1.priority
            }
        let highestPriority = priorities.max() ?? .zero
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
        
        let totalWidthForLowPriorityFlexViews: CGFloat = zip(viewTypes, subviews).filter { type, subView in
            type == .flex && subView.priority != highestPriority
        }.map {
            $1.sizeThatFits(.zero).width
        }.reduce(0.0) {
            $0 + $1
        }
        
        let zeroWidthLowPriorityFlexView = zip(viewTypes, subviews).filter { type, subView in
            type == .flex && subView.priority != highestPriority
        }.map {
            $1.sizeThatFits(.zero).width
        }.filter {
            $0 == .zero
        }.count
        let fixedViews = viewTypes.filter { $0 == .fixed }.count
        
        // Check there is enough width other than `spacing`.
        let totalSpacing = spacing * Double(subviews.count - zeroWidthLowPriorityFlexView - 1)
        print("# totalSpacing: \(totalSpacing)")
        let availableWidthWithoutSpace: CGFloat = proposedViewSize.width! - totalSpacing
        print("# availableWidthWithoutSpace: \(availableWidthWithoutSpace)")
        
        /// Not enough space for display any view.
        if availableWidthWithoutSpace <= 0 {
            return subviews.map { _ in .zero }
        }
        
        print("# totalWidthForFixedViews: \(totalWidthForFixedViews)")
        print("# totalWidthForLowPriorityFlexView: \(totalWidthForLowPriorityFlexViews)")
        
        let remainingWidthForFlexViews = availableWidthWithoutSpace - totalWidthForFixedViews - totalWidthForLowPriorityFlexViews
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
        
        let highPriorityViewCount = zip(viewTypes, subviews)
            .filter { type, subview in
                type == .flex && subview.priority == highestPriority
            }.count
        let dynamicWidth: CGFloat = if highPriorityViewCount > 0 {
            remainingWidthForFlexViews / CGFloat(highPriorityViewCount)
        } else {
            .zero
        }
        print("# dynamicWidth: \(dynamicWidth)")
        return zip(viewTypes, subviews).map { type, subview in
            if type == .fixed {
                print("# proposedViewSize \(proposedViewSize)")
                return subview.sizeThatFits(proposedViewSize)
            } else {
                if subview.priority == highestPriority {
                    let minHeight = subview.sizeThatFits(ProposedViewSize(width: dynamicWidth, height: .zero)).height
                    let proposedSize = if minHeight == .zero {
                        ProposedViewSize(width: dynamicWidth, height: proposedViewSize.replacingUnspecifiedDimensions().height)
                    } else {
                        ProposedViewSize(width: dynamicWidth, height: .zero)
                    }
                    return subview.sizeThatFits(proposedSize)
                } else {
                    return subview.sizeThatFits(.zero)
                }
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
        print("# subview: \(subviews[0].containerValues)")
        
        var x: CGFloat = .zero
        let totalSpacing = spacing * CGFloat(sizes.filter { $0.width > 0 }.count - 1)
        let totalWidth: CGFloat = sizes.map { $0.width }.reduce(0.0) { $0 + $1 } + totalSpacing
        
        return sizes.reduce(into: []) { list, size in
            let origin = CGPoint(x: -totalWidth/2 + x, y: .zero)
            let frame =  CGRect(origin: origin, size: size)
            x += size.width + (size.width == .zero ? .zero: spacing)
            list.append(frame)
        }
    }
}


// MG Examples
#Preview("Spacer") {
    VStack(spacing: 100) {
        HStack(spacing: 10) {
            Rectangle().fill(.red)
            Spacer()
            Rectangle().fill(.yellow)
        }
        MyHStack(spacing: 10) {
            Rectangle().fill(.red)
            Spacer()
            Rectangle().fill(.yellow)
        }
    }
    
}

#Preview("Spacer") {
    VStack(spacing: 100) {
        HStack(spacing: 40) {
            Rectangle().fill(.red)
                .layoutPriority(99)
            Spacer()
            Rectangle().fill(.yellow)
                .layoutPriority(100)
        }
        MyHStack(spacing: 40) {
            Rectangle().fill(.red)
                .layoutPriority(99)
            Spacer()
            Rectangle().fill(.yellow)
                .layoutPriority(100)
        }
    }
}


#Preview("Text and Rectangle") {
    VStack(spacing: 10) {
        HStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.red)
                .frame(minHeight: 100)
            Text("a")
            Rectangle().fill(.red)
        }
        MyHStack(spacing: 10) {
            Text("a")
            Rectangle().fill(.green)
                .frame(minHeight: 100)
            Text("a")
            Rectangle().fill(.green)
        }
    }
}

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

