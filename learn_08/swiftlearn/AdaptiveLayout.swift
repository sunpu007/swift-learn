//
//  AdaptiveLayout.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/2.
//

import SwiftUI
// 自适应布局技巧
struct AdaptiveLayout: View {
    var body: some View {
        // 自适应容器
        ViewThatFits {
            // 宽屏布局
            HStack {
                content
                detailsView
            }
            // 窄屏布局
            VStack {
                content
                detailsView
            }
        }
    }
    
    var content: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.orange)
            .frame(height: 200)
    }
    
    var detailsView: some View {
        Text("详细信息区域")
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
    }
}

#Preview {
    AdaptiveLayout()
}
