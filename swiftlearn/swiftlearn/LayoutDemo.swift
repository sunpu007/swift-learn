//
//  LayoutDemo.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/2.
//

import SwiftUI
// 布局容器对比
struct LayoutDemo: View {
    var body: some View {
        VStack(spacing: 20) {
            // 弹性空间
            Spacer()
            // 水平布局
            HStack {
                Circle().fill(.red)
                Circle().fill(.green)
            }
            .frame(height: 100)
            // 堆叠布局
            ZStack {
                Circle().fill(.blue)
                Text("中心").foregroundStyle(.white)
            }
            .frame(height: 100)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.2))
    }
}

#Preview {
    LayoutDemo()
}
