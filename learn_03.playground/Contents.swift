import Foundation

// 第8课：集合遍历大师（数组/字典）
// 定义订单结构
struct Order {
    let id: Int
    var items: [String]
    var totalPrice: Double
    var isCompleted: Bool
}
// 模拟数据
var orders = [
    Order(id: 101, items: ["T恤", "帽子"], totalPrice: 298.0, isCompleted: false),
    Order(id: 102, items: ["运动鞋"], totalPrice: 599.0, isCompleted: true),
    Order(id: 103, items: ["手机壳", "贴膜"], totalPrice: 88.0, isCompleted: false)
]
// 任务1：遍历未完成订单
for order in orders where !order.isCompleted {
    print("待处理订单ID：\(order.id) 金额：\(order.totalPrice)")
}
// 任务2：修改订单状态
for index in orders.indices where orders[index].totalPrice > 100 {
    orders[index].isCompleted = true;
}
print("订单数据：\(orders)")

// 第9关：循环控制语句（break/continue）
func checkPasswordStrength(_ password: String) -> String {
    var hasNumber = false
    var hasSpecialCahr = false
    
    if password.count < 8 {
        print("密码长度最少8位")
        return ""
    }
    
    for char in password {
        // 遇到空格立即终止检查
        if (char == " ") {
            print("密码不能包含空格")
            break
        }
        // 跳过普通字母检查
        if char.isLetter { continue }
        if char.isNumber {
            hasNumber = true
        } else {
            hasSpecialCahr = true;
        }
    }
    
    switch(hasNumber, hasSpecialCahr) {
    case (true, true): return "强密码"
    case (true, false): return "中密码"
    default: return "弱密码"
    }
}
// 测试用例
print(checkPasswordStrength("Swift2023!")) // 强密码
print(checkPasswordStrength("hello world")) // 弱密码（包含空格）

// 第10战：模式匹配进阶（guard语句）
func validateRegistration(username: String, password: String, mobile: String, email: String?) -> Bool {
    // 第一层验证：用户名
    guard !username.isEmpty, username.count >= 4 else {
        print("用户名至少四位")
        return false
    }
    // 第二层验证：密码
    guard password.count >= 8, password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil else {
        print("密码需8位以上且包含数字")
        return false
    }
    // 第三层验证：邮箱
    if let email: String = email {
        guard email.contains("@"), email.split(separator: "@").last?.contains(".") == true else {
            print("邮箱格式错误")
            return false
        }
    }
    // 验证手机号
    guard !mobile.isEmpty, mobile.starts(with: "1"), mobile.count == 11 else {
        print("手机号格式错误")
        return false
    }
    return true;
}
// 使用案例
validateRegistration(username: "dev", password: "12345678", mobile: "13072970180", email: "test.com") // 失败
validateRegistration(username: "coder", password: "swift5.9", mobile: "1307297018", email: "test@example.com") // 成功
