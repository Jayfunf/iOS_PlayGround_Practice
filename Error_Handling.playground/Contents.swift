import UIKit

/* 오류처리 */

// MARK: - 오류표현
// Error 프로토콜과 (주로) 열거형을 통해서 오류를 표현한다.

/*
enum 오류종류이름: Error{
    case 종류1
    case 종류2
    case 종류3
    //...
}
*/

// 자판기 동작 오류의 종류를 표현한 VendingMchineError 열거형
enum VendingMachineError: Error{
    case invalidInput // 잘못된 인풋이다.
    case insufficientFunds(moneyNeeded: Int) // 돈이 모자라다(얼마가 모자른가).
    case outOfStock // 물건이 다 떨어졌다.
}

// MARK: - 함수에서 발생한 오류 던지기

// 자판기 동작 도중 발생한 오류 던지기
// 오류 발생의 여지가 있는 메서드는 throws를 사용하여
// 오류를 내포하는 함수임을 표시한다.
class VendingMachine{
    let itemPrice: Int = 100
    var itemCount: Int = 5
    var deposited: Int = 0
    
    // 돈 받기 메서드
    func receiveMoney(_ money: Int) throws {
        
        // 입력한 돈이 0이하면 오류를 던진다.
        guard money > 0 else{
            throw VendingMachineError.invalidInput
        }
        
        // 오류가 없으면 정상처리를 한다.
        self.deposited += money
        print("\(money)원 받음")
    }
    
    func vend(numberOfItems numberOfItemsToVend: Int) throws -> String{
        
        // 원하는 아이템의 수량이 잘못 입력되었으면 오류를 던진다.
        guard numberOfItemsToVend > 0 else {
            throw VendingMachineError.invalidInput
        }
        
        // 구매하려는 수량보다 미리 넣어둔 돈이 적으면 오류를 던진다.
        guard numberOfItemsToVend * itemPrice <= deposited else{
            let moneyNeeded: Int
            moneyNeeded = numberOfItemsToVend * itemPrice - deposited
            
            throw VendingMachineError.insufficientFunds(moneyNeeded: moneyNeeded)
        }
        
        // 구매하려는 수량보다 요구하는 수량이 많으면 오류를 던진다.
        guard itemCount >= numberOfItemsToVend else{
            throw VendingMachineError.outOfStock
        }
        
        // 오류가 없으면 정상처리를 한다.
        let totalPrice = numberOfItemsToVend * itemPrice
        
        self.deposited -= totalPrice
        self.itemCount -= numberOfItemsToVend
        
        return "\(numberOfItemsToVend)개 제공함"
    }
}

// 자판기 인스턴스
let machine: VendingMachine = VendingMachine()

// 판매 결과를 전달받을 변수
var result: String?

// MARK: - 오류처리

// 오류발생의 여지가 있는 throws 함수(메서드)는
// try를 사용하여 호출해야한다.
// try, try?, try!

// MARK: do-catch

do{
    try machine.receiveMoney(0)
} catch VendingMachineError.invalidInput{
    print("입력이 잘못되었습니다.")
} catch VendingMachineError.insufficientFunds(let moneyNeeded){
    print("\(moneyNeeded)원이 부족합니다.")
} catch VendingMachineError.outOfStock{
    print("수량이 부족합니다.")
} // 입력이 잘못되었습니다.

// catch catch catch하기 귀찮다면 아래와 같이 할 수 있다.
do{
    try machine.receiveMoney(300)
} catch /* (let error) */ { // 주석은 암시적인 것임 따로 작성할 필요가 없음.
    switch error{
    case VendingMachineError.invalidInput:
        print("입력이 잘못되었습니다.")
    case VendingMachineError.insufficientFunds(let moneyNeeded):
        print("\(moneyNeeded)원이 부족합니다.")
    case VendingMachineError.outOfStock:
        print("수량이 부족합니다.")
    default:
        print("알 수 없는 오류 \(error)")
    }
} // 300원 받음

// 이것도 귀찮다!!
do{
    result = try machine.vend(numberOfItems: 4)
} catch {
    print(error)
} // insufficientFunds(moneyNeeded: 100)

//do{
//    result = try machine.vend(numberOfItems: 4)
//} // 이렇게 줄이는 것도 가능하다. 하지만 이것도 깰껌하지 않다면 밑을 보라

// MARK: - try? 와 try!

// try?
// 별도의 오류처리 결과를 통보받지 않고
// 오류가 발생했으면 결과값을 nil로 돌려받을 수 있다.
// 정상동작 후에는 옵셔널 타입으로 정상 반환값을 돌려 받는다.

result = try? machine.vend(numberOfItems: 2) // 정상 작동하면 함수의 결과값이 result로 들어갈 것이다.
result // "2개 제공함"

result = try? machine.vend(numberOfItems: 2) // 만약 오류가 발생하면 nil이 할당될 것이다.
result // nil

// try!
// 오류가 발생하지 않을 것이라는 강력한 확신을 가질 떄
// try!를 사용하면 정상동작 후에 바로 결과값을 돌려받는다.
// 오류가 발생하면 런타임 오류가 발생하여
// 애플리케이션 동작이 중지된다.

result = try! machine.vend(numberOfItems: 1)
result // "1개 제공함"

//result = try! machine.vend(numberOfItems: 1) // 정상작동 하지 않아 error를 뱉고 프로그램이 죽는다.
