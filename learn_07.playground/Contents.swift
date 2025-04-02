import Foundation
import UIKit
// Swift 高级并发编程实战篇

// 第23课：结构化并发与任务组
func downloadFile(url: URL) async throws -> Data {
    // 模拟下载
    try await Task.sleep(nanoseconds: 1_000_000_000)
    return Data("\(url.lastPathComponent) 内容".utf8)
}

func processBatchDownloads() async {
    let urls = [
        URL(string: "https://myjerry.cn/images/image-20201124120633052.png")!,
        URL(string: "https://myjerry.cn/images/image-20201124122800195.png")!
    ]
    
    await withTaskGroup(of: Data.self) { group in
        // 创建子任务
        for url in urls {
            group.addTask {
                return (try? await downloadFile(url: url)) ?? Data()
            }
        }
        
        // 收集结果
        var combinedData = Data()
        for await result in group {
            combinedData.append(result)
        }
        
        print("合并文件大小：\(combinedData.count) 字节")
    }
}
//await processBatchDownloads()

// 第24关：AsyncStream 实时数据流
struct SensorData {
    let temperature: Double
    let humidity: Double
    let timeStamp = Date()
}

class SensorMonitor {
    private var continuation: AsyncStream<SensorData>.Continuation?
    
    lazy var dataStream: AsyncStream<SensorData> = {
        AsyncStream { continuation in
            self.continuation = continuation
        }
    }()
    
    func startMonitoring() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {  [weak self] _ in
            let newData = SensorData(
                temperature: Double.random(in: 20...30),
                humidity: Double.random(in: 30...70)
            )
            self?.continuation?.yield(newData)
        }
    }
}

let monitor = SensorMonitor()
Task {
    for await data in monitor.dataStream {
        print("[\(data.timeStamp)] 温度：\(data.temperature)°C 湿度：\(data.humidity)%")
    }
}
monitor.startMonitoring()

// 第25战：资源共享与隔离
actor ConcurrentCache<Key: Hashable & Sendable, Value: Sendable> {
    private var storage: [Key: Value] = [:]
    private var accessLog: [Key: Date] = [:]
    
    func getValue(for key: Key) -> Value? {
        accessLog[key] = Date()
        return storage[key]
    }
    
    func setValue(_ value: Value, for key: Key) {
        storage[key] = value
        accessLog[key] = Date()
    }
    
    func cleanUpExpired(threshold: TimeInterval) {
        let now = Date()
        for (key, date) in accessLog {
            if now.timeIntervalSince(date) > threshold {
                storage.removeValue(forKey: key)
                accessLog.removeValue(forKey: key)
            }
        }
    }
}
// 使用示例
let imageCache = ConcurrentCache<URL, UIImage>()
Task {
    await imageCache.setValue(UIImage(), for: URL(string: "https://myjerry.cn/images/image-20201124120633052.png")!)
}

// 阶段项目：分布式任务队列
final class TaskQueue: @unchecked Sendable {
    private let lock = NSLock()
    private var pendingTasks: [CheckedContinuation<Void, Never>] = []
    
    func enqueue() async {
        await withCheckedContinuation { continuation in
            lock.lock()
            if pendingTasks.isEmpty {
                continuation.resume()
            } else {
                pendingTasks.append(continuation)
            }
            lock.unlock()
        }
    }
    
    func dequeue() {
        lock.lock()
        defer { lock.unlock() }
        
        guard !pendingTasks.isEmpty else { return }
        let next = pendingTasks.removeFirst()
        next.resume()
    }
}

let queue = TaskQueue()
Task {
    for i in 1...5 {
        await queue.enqueue()
        print("开始处理任务 \(i)")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        print("完成任务 \(i)")
        queue.dequeue()
    }
}
