import UIKit

// MARK: 클래스
class Adder{
    typealias plus = Int //plus라는 이름의 Int타입 재정의
    
    private var num: Int = 0
    
    func plusNum(target:Int)-> Int{
        num = num+target
        print(num)
        return num
    }
    
    func returnNum()-> Int{
        print(num)
        return num
    }
}

class Adder2:Adder{ //클래스 상속 Adder2가 Adder를 상속 즉, Adder는 부모, Adder2는 자식
    override func plusNum(target: Int)->Int{
        super.plusNum(target: target+10) //여기서 두 번째 target은 오버라이드된 Adder2속 func의 매개변수 target
    }
}

var adder2 = Adder2()

adder2.plusNum(target: 20)

// MARK: 야곰 클래스
// 구조체와 클래스는 유사하다. 다만 구조체는 값타입이며 클래스는 참조타입임.

// 스위프트는 다중 상속 불가능

class Sample{
    
    var mutableProperty = 100
    let immutableProperty = 100
    static var typeProperty = 100
    static let typeProperty2 = 100
    // 타입 메소드
    // 재정의 불가 타입 메소드
    static func typeMethod(){
        print("type Method - static")
    }
    
    // 재정의 가능 타입 메소드
    class func classMethod(){
        print("type Method - class")
    }
}

// MARK: 클래스의 사용

// 클래스는 구조체와 다르게 var나 let이나 뮤터블 프로퍼티를 바꿔줄 수 있다. 밑을 참고하자.

var mutableReference = Sample()
let immutableReference = Sample()

mutableReference.mutableProperty = 200 // 변경 가능
//mutableReference.immutableProperty = 200 // 변경 불가능

immutableReference.mutableProperty = 200 // 변경 가능
//immutableReference.immutableProperty = 200 // 변경 불가능

Sample.typeProperty = 200

