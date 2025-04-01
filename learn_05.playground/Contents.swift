import Foundation
// Swift泛型与错误处理实战篇

// 第17课：泛型基础应用
// 泛型栈结构
struct Stack<Element> {
    private var elements: [Element] = []
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    mutating func pop() -> Element? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeLast()
    }
    
    func peek() -> Element? {
        elements.last
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
}
// 使用示例
var intStack = Stack<Int>()
intStack.push(1)
intStack.push(3)
print(intStack.pop() ?? "空栈") // 输出：3

var stringStack = Stack<String>()
stringStack.push("Swift")
print(stringStack.peek() ?? "空栈") // 输出：Swift

// 第18关：协议关联类型
protocol RequestHandler {
    associatedtype RequestType
    associatedtype ResponseType
    
    func handleRequest(_ request: RequestType) async throws -> ResponseType
}

struct UserRequest {
    let userId: String
}

struct UserResponse {
    let name: String
    let email: String
}


class UserRequesthandler: RequestHandler {
    func handleRequest(_ request: UserRequest) async throws -> UserResponse {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return UserResponse(name: "John", email: "john@example.com")
    }
}

// 第19战：错误处理实战
enum FileError: Error {
    case fileNotFound
    case permissionDenied
    case invalidFormat
    case fileTooLarge(maxSize: Int)
}
class FileManager {
    func readFile(path: String) throws -> Data {
        // 模拟可能出现的错误
        let fileExists = Bool.random()
        let hasPermission = Bool.random()
        
        guard fileExists else {
            throw FileError.fileNotFound
        }
        
        guard hasPermission else {
            throw FileError.permissionDenied
        }
        
        return Data()
    }
    
    func processFile() {
        do {
            let data = try readFile(path: "/documents/report.txt")
            print("文件处理成功")
        } catch FileError.fileNotFound {
            print("文件不存在")
        } catch FileError.permissionDenied {
            print("没有访问权限")
        } catch {
            print("未知错误：\(error)")
        }
    }
}
// 使用示例
let manager = FileManager()
manager.processFile()

// 阶段项目：天气预报应用
enum WeatherError: Error {
    case invalidLocation
    case networkFailure
    case dataParsingError
}
struct WeatherData: Decodable {
    let temperature: Double
    let humidity: Int
    let condition: String
}
class WeatherService {
    func fetchWeather(for city: String) async throws -> WeatherData {
        // 模拟网络请求
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        // 模拟随机错误
        let successRate = Int.random(in: 1...10)
        switch successRate {
        case 1...3:
            throw WeatherError.networkFailure
        case 4...5:
            throw WeatherError.invalidLocation
        default:
            return WeatherData(
                temperature: Double.random(in: -10...50),
                humidity: Int.random(in: 30...90),
                condition: ["晴", "多云", "雨"].randomElement()!
            )
        }
    }
}

// 使用示例
let service = WeatherService()
Task {
    do {
        let data = try await service.fetchWeather(for: "北京")
        print("温度：\(data.temperature)°C 天气：\(data.condition)")
    } catch WeatherError.invalidLocation {
        print("城市名无效")
    } catch WeatherError.networkFailure {
        print("网络连接失败")
    } catch {
        print("获取天气失败：\(error)")
    }
}
