//
//  ProfileCard.swift
//  learn_09
//
//  Created by Jerry on 2025/4/3.
//

import SwiftUI
// 综合练习：构建个人资料卡片
struct ProfileCard: View {
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("blog-avatar")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("李小明")
                        .font(.title2)
                    Text("IOS开发者")
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button {
                    isExpanded.toggle()
                } label: {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }
            if isExpanded {
                Text("擅长Swift UI和Combine框架开发")
                    .transition(.slide)
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    ProfileCard()
}
