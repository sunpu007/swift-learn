//
//  NavigationDemo.swift
//  swiftlearn
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 现代导航系统
struct NavigationDemo: View {
    // 导航路径
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(1..<10) { num in
                NavigationLink("Item \(num)", value: num)
            }
            .navigationDestination(for: Int.self) { num in
                DetailView(number: num)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("跳到第5页") {
                        path.append(5)
                    }
                }
            }
        }
    }
}

struct DetailView: View {
    let number: Int
    
    var body: some View {
        VStack {
            Text("详细信息 \(number)")
                .font(.largeTitle)
            Image(systemName: "\(number).circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    NavigationDemo()
}
