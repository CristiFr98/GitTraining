//
//  ContentView.swift
//  GitTraining
//
//  Created by Cristi on 14.09.2025.
//

import SwiftUI

struct ContentView: View {
    
    var items: [String] = ["Text1","Text2","Text3","Text4","Text5","Text6","Text7","Text8"]
//    var tuples = ()
    
    var body: some View {

//        RoundedRectangle(cornerRadius: 20)
//            .frame(width: 160, height: 160)
//            .foregroundColor(Color.blue.opacity(0.6))
        
//        AdaptiveList(maxFontSize: 32, minItems: 5, fontSizeMultiplier: 1) {
//                ForEach(items, id: \.self) { item in
//                    Text(item)
////                        .font(.system(size: 10))
//                }
//                Text("Title")
////                    .font(.system(size: 10))
//            }
////            .padding()
//            .frame(width: 160, height: 160)
//            .background(Color.blue.opacity(0.6))
        
        NewListType(maxFontSize: 32) {
            ForEach(items, id: \.self) { item in
                Text(item)
//                        .font(.system(size: 10))
            }
            Text("Title")
//                    .font(.system(size: 10))
        }
//            .padding()
        .frame(width: 160, height:160)
//        .frame(height: .infinity)
        .background(Color.red)
            
        
    }
}


struct NewListType: Layout {
    
    var maxFontSize: CGFloat
//    var fontSizeMultiplier: CGFloat = 1
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
//        guard !subviews.isEmpty else { return .zero }
//        
//        let maxSize = maxSize(subviews: subviews)
//        let spacing = spacing(subviews: subviews)
//        let totalSpacing = spacing.reduce(0) { $0 + $1 }
//        
//        return CGSize(
//            width: maxSize.width,
//            height: maxSize.height * CGFloat(subviews.count) + totalSpacing)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }
        
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        
//        var fontSize = maxFontSize * fontSizeMultiplier
        var newMultiplier = CGFloat(1)
        
        func finalHeight(for multiplier: CGFloat) -> CGFloat {
            CGFloat(subviews.count) * maxFontSize * multiplier + totalSpacing
//            CGFloat(subviews.count) * multiplier + totalSpacing
        }
        
        while finalHeight(for: newMultiplier) > bounds.height && newMultiplier > 0.1 {
            newMultiplier -= 0.1
        }
        
        let finalItemSize: CGFloat = maxFontSize * newMultiplier
        
//        let placementProposal = ProposedViewSize(
//            width: maxSize.width,
//            height: maxSize.height)
        
//        var nextY = bounds.minY + maxSize.height / 2
        
        let placementProposal = ProposedViewSize(
            width: maxSize.width,
            height: finalItemSize)
        
        var nextY = bounds.minY + finalItemSize / 2
        
        for index in subviews.indices {
            subviews[index].place(
                at: CGPoint(x: bounds.minX, y: nextY),
                anchor: .leading,
                proposal: placementProposal)
            nextY += finalItemSize + spacing[index]
        }
    }
    
    private func maxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSizes in
            CGSize(
                width: max(currentMax.width, subviewSizes.width),
                height: max(currentMax.height, subviewSizes.height))
        }
        return maxSize
    }
    
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .vertical)
        }
    }
    
    
}





struct AdaptiveList: Layout {
    
    var maxFontSize: CGFloat
    var minItems: Int
    var fontSizeMultiplier: CGFloat
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        guard !subviews.isEmpty else { return }
        let availableHeight = bounds.height
        let itemCount = subviews.count
        
        var fontSize = maxFontSize * fontSizeMultiplier
        
        func totalHeight(for size: CGFloat) -> CGFloat {
            CGFloat(itemCount) * size * 1
        }
        
        while totalHeight(for: fontSize) > availableHeight && fontSize > 1 {
            fontSize -= 1
        }
        
        var y = bounds.minY
        for subview in subviews {
            let height = fontSize * 1
            subview.place(
                at: CGPoint(x: bounds.minX, y: y),
                proposal: ProposedViewSize(width: bounds.width, height: height)
            )
            y += height
        }
        
    }
}


#Preview {
    ContentView()
}
