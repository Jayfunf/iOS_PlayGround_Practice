import UIKit

struct Sample{
    var mutableProperty: Int = 100 //가변(var)프로퍼티
    let immutableProperty: Int = 100 //불변(let)프로퍼티
    
    static var typeProperty: Int = 100 //타입 프로퍼티 //Sample스트럭트에서 사용할 수 있는 타입 프로퍼티 //<-static
    
    //인스턴스 메소드
    func instanceMethod(){
        print("instanceMethod")
    }
    
    static func typeMethod(){
        print("typeMethod")
    }
}

var mutable:Sample = Sample() //var이기 때문에 가변 인스턴스

mutable.mutableProperty = 200 //변경 가능
//mutable.immutableProperty = 200 //변경 불가능

let immutable:Sample = Sample()

//immutable.mutableProperty = 200 //변경 불가능
//immutable.immutableProperty = 200 //변경 불가능

//타입 프로퍼티 및 메서드
Sample.typeProperty = 300
Sample.typeMethod()


struct Student{
    static var name: String = "min"
    var name2: String = "jay"
}

Student.name = "minhuyn" //static 직접 변경
var stu = Student()
stu.name2 = "minhyun" //non-static 간접 변경

//static이 붙으면 직접 접근해서 사용 가능
//만약 static이 아니라면 var sample = Sample()과 같은 식으로 접근해서 사용가능
//단 어떤 방식으로 접근하든 var가 아니면 값을 변경하는 것은 불가능함
