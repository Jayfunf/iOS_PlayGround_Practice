import UIKit

//value type
// enum, struct는 값타입이다.
//  enum
//   열거형 자체가 하나의 데이터 타입이다. 열거형의 case 하나 하나 의미 있는 값이다.

//reference type
// class는 참조타입이다.

//class/ enum/ struch
// 여기서 클래스만 유일한 참조 타입이며, 유일하게 상속이 가능하다.

//구조체는 언제 사용하는가?
// 연관된 몇몇의 값들을 모아서 하나의 데이터타입으로 표현하고 싶을 때 사용한다. 이는 클래스도 비슷하다.
// 하지만 다른 객체 또는 함수 등으로 전달될 때 참조가 아닌 복사를 원할 때 사용한다.
// 또 상속할 필요가 없을 때 사용해도 무방하다.
// 애플 프레임워크 즉, iOS나 macOS에서 프로그래밍 할 때는 주로 클래스를 이용한다.

//value VS reference
// value
//  데이터를 전달할 때 값을 복사하여 전달
// reference
//  데이터를 전달할 때 값의 메모리 위치를 전달

/* 값 타입과 참조 타입 비교*/

struct ValueType{
    var property: Int = 1
}

class ReferenceType{
    var property: Int = 1
}

let firstStructInstance = ValueType() // 벨류타입 인스턴스 할당
var secondStructInstance = firstStructInstance //첫번째 구초제 인스턴스를 할당
secondStructInstance.property = 2

print("\(firstStructInstance.property)") //1
print("\(secondStructInstance.property)") //2
//즉 second..인스턴스를 생성할 때, first..인스턴스 속 프로퍼티와 똑같은 프로퍼티가 할당됨. 즉 복사, 같은 모양의 각각의 property사용

let firstClassInstance = ReferenceType()
var secondClassInstance = firstClassInstance
secondClassInstance.property = 2

print("\(firstClassInstance.property)") //2
print("\(secondClassInstance.property)") //2
// 값이 복사되는 것이 아닌 참조 값이 복사되어 할당됨. 즉 같은 property를 사용

struct someStruct{
    var someProperty: String = "property"
}
var someValueInstance: someStruct = someStruct()

func someStructFuncion(structInstance: someStruct){
    var localVar: someStruct = structInstance
    localVar.someProperty = "ABC"
}

someStructFuncion(structInstance: someValueInstance)
print(someValueInstance.someProperty) // 무엇이 출력될까? 정답은 property이다.

// someStruct를 받은 someValueInstance가 someFunction에 들어가서 값을 할당하려 해도 someFunction에 매개변수로 들어간
// property는 값을 복사해서 가져간다. 즉 바뀌어도 함수에 매개변수로 들어간 인스턴스의 프로퍼티 값이 바뀌는 것이지 전체가 바뀌는 것은 아니다.

class someClass{
    var someProperty: String = "property"
}
var someClassInstance: someClass = someClass()

func someClassFunction(classInstance: someClass){
    var localVar: someClass = classInstance
    localVar.someProperty = "ABC"
}

someClassFunction(classInstance: someClassInstance)
print(someClassInstance.someProperty) // 당연히 struct의 반대로 ABC가 나오겠지만 아무튼 설명하자면

// 함수에 들어간 someClassInstance의 property는 값이 복사되는 것이 아닌, 메모리 위치가 그래도 전달되기 때문에 덮어쓰기 당한 것이다.

// MARK: Swift Data Type

// public struct Int... 스위프트에 존재하는 데이터 타입들은 모두 구조체로 만들어져있다.

// MARK: Swift Loves Struct
//  Swift에서는 구조체의 사용을 클래스의 사용보다 선호한다. 열거형도 마찬가지.
//  하지만 애플 프레임 워크에서는 클래스를 많이씀 잘 선택해서 사용하셈!
