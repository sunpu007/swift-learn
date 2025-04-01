import Foundation
import UIKit
import Combine

// Swift并发编程实战篇

// 第20课：async/await基础
func downloadImage(url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage(data: data) else {
        throw NSError(domain: "转换图片失败", code: 500)
    }
    return image
}

Task {
    // 并行下载
    async let firstImage = downloadImage(url: URL(filePath: "https://myjerry.cn/images/image-20201121153734585.png")!)
    async let secondImage = downloadImage(url: URL(filePath: "https://myjerry.cn/images/image-20201121151415405.png")!)
    
    let images = try await [firstImage, secondImage]
    print("下载完成 \(images.count) 张图片")
}

// 第21关：Actor数据隔离
actor BankAccount {
    private var balance: Double
    private let accountNumber: String
    
    init(initialBalance: Double) {
        self.balance = initialBalance
        self.accountNumber = UUID().uuidString
    }
    
    func deposit(_ amount: Double) {
        guard amount > 0 else {
            print("存款金额只能为正数")
            return
        }
        balance += amount
    }
    
    func withdraw(_ amount: Double) -> Bool {
        guard amount > 0 else {
            print("取款金额只能为正数")
            return false
        }
        guard balance > amount else {
            print("余额不足")
            return false
        }
        balance -= amount
        return true
    }
    
    func currentBalance() -> Double {
        balance
    }
}
// 使用示例
let account = BankAccount(initialBalance: 1000)
Task {
    await account.deposit(500)
    print(await account.currentBalance()) // 1500.0
}

// 第22战：Combine与异步结合
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var suggestions: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { text in
                Task { [weak self] in
                    self?.suggestions = await self?.fetchSuggestions(for: text) ?? []
                }
            }
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    private func fetchSuggestions(for query: String) async -> [String] {
        // 模拟网络请求
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return []
//        return MockData.SearchSuggestions(for: query);
    }
}

// 阶段项目：即时通讯系统
struct Message {
    let userId: String
    let content: String
}
actor MessageStore {
    private var messages: [Message] = []
    private var pendingMessages: [Message] = []
    
    func send(_ message: Message) async {
        pendingMessages.append(message)
        do {
            try await uploadMessages()
        } catch {
            print("消息发送失败：\(error)")
            await retrySend()
        }
    }
    
    private func uploadMessages() async throws {
        let messagesToSend = pendingMessages
        try await APIClient.sendMessages(messagesToSend)
        messages.append(contentsOf: messagesToSend)
        pendingMessages.removeAll()
    }
    
    private func retrySend() {
        Task {
            try await Task.sleep(nanoseconds: 5_000_000_000)
            try await uploadMessages()
        }
    }
}
class APIClient {
    static func sendMessages(_ messages: [Message]) async throws {
        // 模拟网络请求
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        // 随机失败率30%
        if Bool.random() && 0.3...1.0 ~= 0.3 {
            throw NSError(domain: "网络不稳定", code: 503)
        }
    }
}
