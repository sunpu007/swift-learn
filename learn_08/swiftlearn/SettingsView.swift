//
//  SettingsView.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 状态管理基础 -> 2. 状态管理进阶
class UserSettings: ObservableObject {
    // 可观察属性
    @Published var isDarkMode = false
    @Published var fontSize: Double = 16
}

struct SettingsView: View {
    // 环境对象
    @EnvironmentObject var settings: UserSettings
    @State private var temporaryFontSize: Double = 16
    
    var body: some View {
        Form {
            Toggle("夜间模式", isOn: $settings.isDarkMode)
            
            Slider(value: $temporaryFontSize, in: 12...24) {
                Text("字体大小")
            }
            .onChange(of: temporaryFontSize) { _, newValue in
                settings.fontSize = newValue
            }
        }
    }
}

#Preview {
    SettingsView()
}
