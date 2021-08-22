import UIKit

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

adder2.plusNum(target: 20) //super로 인해 값 적용X
