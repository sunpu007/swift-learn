import Foundation

// 第11课：函数式编程入门
// 基础函数定义
func celsiusToFahrenheit(_ celsius: Double) -> Double {
    return celsius * 9/5 + 32
}
// 多参数函数
func formatTemperature(_ value: Double, scale: String) -> String {
//    return String(format: "%.1f°\(scale)", value)
    "\(value)f°\(scale)"
}
// 函数作为参数
func convertAndPrint(
    value: Double,
    converter: (Double) -> Double,
    formatter: (Double, String) -> String
) {
    let converted = converter(value)
    print(formatter(converted, "F"))
}
// 使用示例
convertAndPrint(
    value: 25.0,
    converter: celsiusToFahrenheit,
    formatter: formatTemperature
) // 输出：77.0°F

// 第12关：结构体实战
struct BankAccount {
    let accountNumber: String
    private(set) var balance: Double
    let owner: String
    init(owner: String, initialDeposit: Double) {
        self.accountNumber = String(Int.random(in: 10000000...99999999))
        self.balance = initialDeposit
        self.owner = owner
    }
    
    mutating func deposit(_ amount: Double) {
        guard amount > 0 else {
            print("存款金额需为正数")
            return
        }
        balance += amount
    }
    
    mutating func withdraw(_ amount: Double) -> Bool {
        guard amount > 0 else {
            print("取款金额需为正数")
            return false
        }
        guard balance > amount else {
            print("余额不足")
            return false
        }
        balance -= amount
        return true
    }
    
    static func validateAccountNumbeer(_ num: String) -> Bool {
        num.count == 8 && num.rangeOfCharacter(from: .decimalDigits) != nil
    }
}
// 使用示例
var account = BankAccount(owner: "张三", initialDeposit: 1000)
account.deposit(500)
account.withdraw(2000) // 余额不足提示
print("当前余额：\(account.balance)") // 1300.0

// 第13战：属性观察器
class Thermostat {
    var currentTemperature: Double = 20.0 {
        didSet {
            // 温度变化超过3度触发警报
            if abs(currentTemperature - oldValue) > 3 {
                print("⚠️ 温度剧烈波动：\(oldValue) → \(currentTemperature)")
            }
            
            // 自动模式调整
            if currentTemperature > 28 {
                coolingSystem(on: true)
            } else if currentTemperature < 16 {
                heatingSystem(on: true)
            } else {
                coolingSystem(on: false)
                heatingSystem(on: false)
            }
        }
    }
    
    private func coolingSystem(on: Bool) {
        print("制冷系统\(on ? "启动" : "关闭")")
    }
    
    private func heatingSystem(on: Bool) {
        print("制热系统\(on ? "启动" : "关闭")")
    }
}
// 测试
let thermostat = Thermostat()
thermostat.currentTemperature = 25 // 正常变化
thermostat.currentTemperature = 18 // 触发剧烈波动警告
thermostat.currentTemperature = 12 // 触发制热系统

// 阶段项目：图书馆管理系统
struct Book {
    let ISBN: String
    let title: String
    var isAvailable: Bool = true
}

class Library {
    private var books: [Book] = []
    // 用户ID: [ISBN]
    private var borrowRecords: [String: [String]] = [:]
    
    // 添加书籍
    func addBook(_ book: Book) {
        guard !books.contains(where: { $0.ISBN == book.ISBN }) else {
            print("已存在相同ISBN书籍")
            return
        }
        books.append(book)
    }
    
    // 借书功能
    func borrowBook(ISBN: String, userID: String) {
        guard let index = books.firstIndex(where: { $0.ISBN == ISBN }) else {
            print("未找到该书")
            return
        }
        guard books[index].isAvailable else {
            print("书籍已被借出")
            return
        }
        books[index].isAvailable = false
        borrowRecords[userID, default: []].append(ISBN)
        print("\(userID) 成功借阅 ISBN: \(ISBN)")
        print(borrowRecords)
    }
    
    // 展示库存
    func displayInventory() {
        print("\n当前库存：")
        books.forEach{
            print("[\($0.ISBN)] \($0.title) \($0.isAvailable ? "🟢" : "🔴")")
        }
    }
}
// 使用示例
let library = Library()
library.addBook(Book(ISBN: "9787100000001", title: "Swift编程入门"))
library.addBook(Book(ISBN: "9787100000002", title: "iOS开发实战"))

library.borrowBook(ISBN: "9787100000001", userID: "U123")
library.displayInventory()
