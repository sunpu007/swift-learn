//
//  CounterView.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 状态管理基础 -> 1. 状态绑定原理
struct CounterView: View {
    // 私有状态
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("点击次数：\(count)")
                .font(.title)
            Button("增加") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
            // 状态绑定传递
            ChildView(count: $count)
        }
    }
}

struct ChildView: View {
    // 绑定状态
    @Binding var count: Int
    
    var body: some View {
        Button("重置") {
            count = 0
        }
    }
}

#Preview {
    CounterView()
}
