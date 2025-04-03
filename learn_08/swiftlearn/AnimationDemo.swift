//
//  AnimationDemo.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 动画与交互 -> 1.基础动画
struct AnimationDemo: View {
    @State private var isAnimated = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 10)
                .fill(isAnimated ? .orange : .blue)
                .frame(
                    width: isAnimated ? 200 : 100,
                    height: isAnimated ? 200 : 100
                )
                .rotationEffect(.degrees(isAnimated ? 360 : 0))
                .animation(
                    .spring(response: 0.5, dampingFraction: 0.3),
                    value: isAnimated
                )
            
            Button("切换状态") {
                isAnimated.toggle()
            }
        }
    }
}

#Preview {
    AnimationDemo()
}
