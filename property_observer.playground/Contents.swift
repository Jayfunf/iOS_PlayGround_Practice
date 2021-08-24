import UIKit

// MARK: - 정의

struct Money{
    // 프로퍼티 감시자 사용
    // currencyRate라는 프로퍼티 값이 변경이 될 때, 블럭안의 willSet과 didSet이 실행이 된다.
    var currencyRate: Double = 1000{
        willSet(newRate){ // will 즉 앞으로 바뀔 것이다. (바뀌기 직전) // newRate는 바뀔 값
            print("환율이 \(currencyRate)에서 \(newRate)으로 변경될 예정입니다.")
        }
        didSet(oldRate){ // did 즉 바뀌었다. (바뀐 직후) // 바뀌기 이전의 값
            print("환율이 \(oldRate)에서 \(currencyRate)으로 변경되었습니다.")
        }
    }
    
    var dollar: Double = 0{
        willSet{ // 주의: 매개변수 없음 암시적으로 적용됨.
            print("\(dollar)달러에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet{
            print("\(oldValue)달러에서 \(dollar)달러로 변경되었습니다.")
        }
    }
    
    // 연산 프로퍼티
    var won: Double{
        get{
            return dollar * currencyRate
        }
        set{
            dollar = newValue / currencyRate
        }
        
        /*
         프로퍼티 감시자와 연산 프로퍼티 기능을 동시에 사용할 수 없다.
         
         당연하다. willSet, didSet은 저장되는 값이 변경될 때 호출되는 것이기 때문이다.
         */
    }
}

// MARK: - 사용

var moneyInMyPocket: Money = Money()

// 환율이 1100.0에서 1150.0으로 변경될 예정입니다.
moneyInMyPocket.currencyRate = 1150
// 환율이 1100.0에서 1150.0으로 변경되었습니다.

// 0.0달러에서 10.0달러로 변경될 예정입니다.
moneyInMyPocket.dollar = 10
// 0.0달러에서 10.0달러로 변경되었습니다.

print(moneyInMyPocket.won)
// 11500.0

/*
 프로퍼티 감시자의 기능은
 함수, 메서드, 클로저, 타입 등의 외부에 위치한
 지역/전역 변수에도 모두 사용 가능하다.
 */
