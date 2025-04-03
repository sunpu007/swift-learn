//
//  BasicComponents.swift
//  learn_09
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 基础组件
/**
 通过链式调用修饰视图，方法的顺序会影响最终的展示效果。如：padding与background，background在后的话会覆盖padding区域
 */
struct BasicComponents: View {
    @State private var username: String = ""
    @State private var isNotificationEnabled: Bool = false
    @State private var volume: Double = 30.0
    
    var body: some View {
        // 文本组件
        Text("欢迎学习Swift UI")
            .font(.title)
            .foregroundStyle(.blue)
            .padding()
            .background(.yellow)
            .cornerRadius(10)
        // 按钮与交互
        Button(action: {
            print("按钮被点击")
        }) {
            HStack {
                Image(systemName: "star.fill")
                Text("收藏")
            }
        }
        .buttonStyle(.borderedProminent)    // 系统预设样式
        .tint(.purple)  // 主体色
        // 图片组件
        Image("blog-avatar")   // 资源图片
            .resizable()    // 允许缩放
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)  // 限制尺寸
        Image(systemName: "heart.fill") // SF Symbols
            .font(.system(size: 40))
            .symbolRenderingMode(.multicolor)
        // 网络图片展示
        AsyncImage(url: URL(string: "https://myjerry.cn/images/avatar/blog-avatar.jpg")) { phase in
            if let image = phase.image {
                image.resizable()
            } else if phase.error != nil {
                Image("placeholder")
            } else {
                ProgressView()
            }
        }
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)
        // 表单控件 -> 文本输入
        TextField("请输入用户名", text: $username)
            .textFieldStyle(.roundedBorder)
        // 表单控件 -> 开关
        Toggle("启用通知", isOn: $isNotificationEnabled)
            .toggleStyle(.switch)
        // 表单控件 -> 滑动条
        Slider(value: $volume, in: 0...100, step: 1.0)
            .tint(.orange)
    }
}

#Preview {
    BasicComponents()
}
