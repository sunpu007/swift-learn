//
//  learn_09App.swift
//  learn_09
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI

// SwiftUI 应用基本结构
/**
 @main 标记应用入口
 App 定义应用的主体结构和生命周期
 Scene 表示应用程序中的一个窗口或界面（支持多窗口）
 View 所有UI组件都必须遵守，通过body属性定义内容
 */
@main
struct learn_09App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello SwiftUI")
    }
}

struct ParamsView: View {
    var name: String
    var body: some View {
        Text("我是传进来的内容：\(name)")
    }
}

// #Preview 定义一个预览视图
#Preview("light") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("dark") {
    ContentView()
        .preferredColorScheme(.dark)
}

#Preview("Group") {
    Group {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}

#Preview("params") {
    ParamsView(name: "123")
}

#Preview("大字体") {
    ContentView()
        .environment(\.sizeCategory, .accessibilityExtraLarge)
}
