//
//  StateView.swift
//  learn_09
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI

// 状态管理
/**
 @State 特性：
    - 用于视图私有简单数据
    - 值类型优先（String、Int、Bool等）
    - 修改自动触发视图重建
 */
struct StateView: View {
    @State private var count: Int = 0    // 私有状态
    @State private var isOn: Bool = false
    
    var body: some View {
        // 状态属性
        Button("点击 \(count) 次") {
            count += 1  // 修改触发视图更新
        }
        // 绑定传递
        ChildView(isOn: $isOn)  // $传递绑定
    }
}

// @Binding 作用：在父子视图间共享状态修改。
struct ChildView: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle("开关", isOn: $isOn)
    }
}

#Preview {
    StateView()
}
