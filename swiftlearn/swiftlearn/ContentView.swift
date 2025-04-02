//
//  ContentView.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/2.
//

import SwiftUI
// 基础组件实战
struct ContentView: View {
    @State private var toggleState = false
    
    var body: some View {
        VStack {
            // 图片组件
            Image(systemName: "swift")
                .imageScale(.large)
                .foregroundStyle(.tint)
            // 文本组件
            Text("Hello, world!")
                .font(.largeTitle)
                .foregroundStyle(.blue)
            // 输入框组件
            TextField("请输入你的名字", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding()
            // 开关组件
            Toggle("启用功能", isOn: $toggleState)
                .toggleStyle(.switch)
            // 进度条组件
            ProgressView(value: 0.7)
                .progressViewStyle(.linear)
            // 按钮组件
            Button("按钮") {
                toggleState = !toggleState
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
