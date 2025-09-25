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
        
        ZStack {
            Color.orange.opacity(0.2).ignoresSafeArea()
            
            NewListType() {
                
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    Text(item).fixedSize()
                    //                    .font(.system(size: 10))
                }
                //            Text("Title")
                //                    .font(.system(size: 10))
            }
            .frame(width: 160, height:160)
            //        .frame(height: .infinity)
            .background(Color.red)
            
        }
        .overlay(alignment: .topLeading) {
            Circle()
                .position(x: 121, y: 357)
                .frame(width: 20, height: 20)
                .foregroundColor(Color.green)
        }
        .ignoresSafeArea()
    }
}


struct NewListType: Layout {
    
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
        print("=== Layout Pass ===")
        print("Bounds: \(bounds)")
        print("Proposal: \(proposal)")
        print("Subviews count: \(subviews.count)")
        
        let spacing = spacing(subviews: subviews)
//        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        
        
        
        let measureProposal = ProposedViewSize(
            width: bounds.width,
            height: nil)
        
        var currentY = bounds.minY
        print("\(currentY), bounds: \(bounds)")
//        var subviewsPlaced: Int = 0
        
        for index in subviews.indices {
            let subviewSize = subviews[index].sizeThatFits(measureProposal)
            if currentY + subviewSize.height + spacing[index] < bounds.maxY {
                subviews[index].place(
                    at: CGPoint(x: bounds.minX, y: currentY),
//                    anchor: .topLeading,
                    proposal: ProposedViewSize(width: bounds.width, height: subviewSize.height))
                currentY += subviewSize.height + spacing[index]
                print("\(currentY), index: \(index)")
            } else {
                subviews[index].place(at: CGPoint(x: -10_000, y: -10_000), proposal: .unspecified)
                print("Else: \(index), Y: \(currentY)")
            }
        }
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


#Preview {
    ContentView()
}
