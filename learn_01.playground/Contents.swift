print("Hello, \(String(repeating: "🐶", count: 3)) World!")

var score = 90
// let 声明的变量为常量
let maxScore = 100

score = 85
// maxScore = 120

let name = "Tom"
let age = 25
let sex = 1

// 不同类型的变量不能进行运算符处理
print(name + String(age))
print(age + sex)

let isStudent = true
let temperature = 36.5

var optionalName: String? = "Alice"
print(optionalName?.uppercased() ?? "无名氏")
// 强制解包
let forcedName = optionalName!
optionalName = nil
//print(optionalName)

func divide(a: Int, b: Int) -> Int? {
    return b == 0 ? nil : a / b
}
print(divide(a: 4, b: 2) ?? 0);

func calculate(num1: Double, num2: Double, operator: String) -> Double? {
    switch `operator` {
        case "+": return num1 + num2
        case "-": return num1 - num2
        case "*": return num1 * num2
        case "/": return num2 == 0 ? nil : num1 / num2
        default: return nil
    }
}
print(calculate(num1: 5, num2: 0, operator: "/") ?? 0)
