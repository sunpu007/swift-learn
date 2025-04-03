//
//  LayoutComponents.swift
//  learn_09
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 布局组件
/**
 VStack 垂直排列
 HStack 水平排列
 ZStack 层叠布局
 Spacer 弹性占位 推动其他视图到边缘
 */
struct LayoutComponents: View {
    @State private var tags: [String] = ["tag1", "tag2", "tag3"]
    
    var body: some View {
        // 基础布局容器
        VStack(spacing: 20) {   // 子视图间距20
            Text("标题").font(.title)
            HStack {
                Image(systemName: "location")
                Text("北京")
            }
            Spacer()    // 撑满剩余空间
        }
        .frame(maxWidth: .infinity) // 最大宽度
        .padding()
        // 动态布局
        HStack {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .padding(5)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5)
            }
        }
        .lineLimit(2)
    }
}

#Preview {
    LayoutComponents()
}
