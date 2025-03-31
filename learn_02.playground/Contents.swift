// 第5课：逻辑决策大师（if-else）
let temperature = 28
var isRaining = false

if temperature > 30 && !isRaining {
    print("🏖️去海边游泳！")
} else if temperature > 20 {
    isRaining ? print("☔️室内看电影") : print("🚴骑行郊游")
} else {
    print("❄️宅家喝热可可")
}

// 第6关：模式匹配专家（switch）
enum Animal {
    case dog(age: Int)
    case cat
    case parrot(name: String)
}

let pet = Animal.dog(age: 1)
switch pet {
case .dog(let age) where age < 1:
    print("幼犬享受8折优惠！")
case .dog, .cat:
    print("常规宠物用品区在A区")
case .parrot(let name) where name == "Polly":
    print("明星鹦鹉专属零食礼包！")
default:
    print("欢迎探索异宠区")
}

// 第7战：循环忍者训练（for-in / while）
// 实战1：分析电商销售数据
let dailySales = [2350, 3980, 1740, 6200, 5100]
var total = 0;
for (index, amount) in dailySales.enumerated() {
    print("周\(index)销售额：\(amount)")
    total += amount
}
print("周平均销售额：\(total / dailySales.count)")
// 实战2：安全登录验证
var attempt = 3
while attempt > 0 {
    print("剩余尝试次数：\(attempt)")
    attempt -= 1
}
print(attempt > 0 ? "登录成功" : "账户锁定")
// 实战2：打印1-100之间所有7的倍数
var num = 1;
var arrs:[Int] = [];
while num < 100 {
    if (num % 7 == 0) {
        arrs.append(num)
    }
    num += 1
}
print("100以内7的倍数的所有数字：\(arrs)")

// 阶段项目：智能售货机
struct Drink {
    let name: String
    var stock: Int
    let price: Int
}

var drinks = [
    Drink(name: "冰美式", stock: 5, price: 15),
    Drink(name: "抹茶拿铁", stock: 3, price: 18),
    Drink(name: "杨枝甘露", stock: 0, price: 20)
]

@MainActor
func buyDrink(name: String, money: Int) {
    for index in drinks.indices {
        guard drinks[index].name == name else { continue }
        
        switch true {
        case drinks[index].stock == 0:
            print("❗️\(name)已售罄")
        case money < drinks[index].price:
            print("❌余额不足，还需\(drinks[index].price - money)元")
        default:
            drinks[index].stock -= 1
            print("✅购买成功，找零\(money - drinks[index].price)元")
        }
    }
    print("⚠️未找到商品")
}
// 测试你的售货机
buyDrink(name: "抹茶拿铁", money: 20)
buyDrink(name: "杨枝甘露", money: 25)
