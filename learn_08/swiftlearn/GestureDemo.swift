//
//  GestureDemo.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 动画与交互 -> 2. 手势交互
struct GestureDemo: View {
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        Circle()
            .fill(.purple)
            .frame(width: 100)
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            dragOffset = .zero
                        }
                    }
            )
    }
}

#Preview {
    GestureDemo()
}
