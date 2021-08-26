import UIKit

// 스위프트의 타입캐스팅은
// 인스턴스의 타입을 확인하는 용도
// 또는 클래스의 인스턴스를
// 부모 혹은 자식 클래스의 타입으로 사용할 수 있는지
// 확인하는 용도로 사용한다.
// is, as를 사용한다.

let someInt: Int = 100
let someDouble: Double = Double(someInt)
// 이것은 Double을 someInt로 타입캐스팅을 하는 것이 아니라 Double타입의 someInt라는 instance를 새로 생성하는 것이다.

// 주로 swift에서는 class의 instance에서 많이 사용할 수 있다.
// 아니면 dictionary의 Any나 AnyObject에서 타입캐스팅을 많이 사용한다.
// 위에서 언급한대로 Any나 AnyObject를 많이 사용한다면 정말 중요하다.

class Person{
    var name: String = ""
    func breath(){
        print("숨을 쉽니다.")
    }
}

class Student: Person{
    var school: String = ""
    func goToSchool(){
        print("등교를 합니다.")
    }
}

class UniversityStudent: Student{
    var major: String = ""
    func goToMT(){
        print("멤버쉽 트레이닝을 갑니다!")
    }
}

var min: Person = Person()
var hana: Student = Student()
var jason: UniversityStudent = UniversityStudent()

// MARK: - 타입 확인
// is를 사용하여 타입을 확인.

var result: Bool

result = min is Person // true
result = min is Student // false
result = min is UniversityStudent // false

result = hana is Person // true
result = hana is Student // true // Student는 Person을 상속 받았기 때문에 true이다.
result = hana is UniversityStudent // false

result = jason is Person // true
result = jason is Student // true
result = jason is UniversityStudent // true

// MARK: - 업 캐스팅
// as를 사용하여 부모클래스의 Instance로 사용할 수 있도록
// 컴파일러에게 타입 정보를 전달한다.
// Any 혹은 AnyObject로도 타입정보를 변환할 수 있다.
// 암시적으로 처리되므로 생략해도 상관 없다.

var mike: Person = UniversityStudent() as Person
var jenny: Student = Student()
//var jina: UniversityStudent = Person() as UniversityStudent // 컴파일 에러

var jina: Any = Student() // 원해는 뒤에 as Any가 붙어있는 것이지만 암시적으로 생략

// MARK: - 다운 캐스팅
// as? 또는 as!를 사용하여
// 자식 클래스의 인스턴스로 사용할 수 있도록
// 컴파일러에게 인스턴스의 타입 정보를 전환

// MARK: - 조건부 다운 캐스팅
// as?

var optionalCasting: Student? // 옵셔널이어야한다. nil이 반환될 수 있는 요소가 존재하기 때문

optionalCasting = mike as? UniversityStudent // UniversityStudent // Person 타입이지만 UniversityStudent도 될 수 있다.
optionalCasting = jenny as? UniversityStudent // nil
optionalCasting = jina as? UniversityStudent // nil
optionalCasting = jina as? Student // Student

// MARK: - 강제 다운 캐스팅
// as!
// 무조건! 해야해!
var forcedCasting: Student

forcedCasting = mike as! UniversityStudent // mike! 너 대학생 해! // 마이크는 그렇게 선언했기에 가능하다.
//forcedCasting = jenny as! UniversityStudent // Error // 하지만 다른 친구들은 학생이거나 사람이라 대학생이 될 수 없다. 따라서 Error
//forcedCasting = jina as! UniversityStudent // Error // 마찬가지 강제로 대학생 행세를 할 수 없다.
//forcedCasting = jina as! Student // Error

// 활용
func doSomeThingWithSwitch(someone: Person){ // 사람이 대학생인지 학생인지 사람인지 판단하는 함수
    switch someone {
    case is UniversityStudent: // 확인만 하는것 // someone이 대학생이면
        (someone as! UniversityStudent).goToMT() // 캐스팅 하는것
    case is Student: // someone이 학생이면
        (someone as! Student).goToSchool()
    case is Person: // someone이 사람이면
        (someone as! Person).breath()
    }
}

// 캐스팅과 반환을 동시에
func doSomeThing(someone: Person){
    if let universityStudent = someone as? UniversityStudent{ // 위와 다르게 확인과 캐스팅을 동시에 // someone이 대학생이면 조건부 다운 캐스팅 // 즉 person에서 unistu...로 다운 캐스팅 최상위 person이 아님
        universityStudent.goToMT() //
    } else if let student = someone as? Student{
        student.goToSchool()
    } else if let person  = someone as? Person{
        person.breath()
    }
}

doSomeThing(someone: mike as Person) // 멤버쉽 트레이닝을 갑니다!

doSomeThing(someone: mike) // 멤버쉽 트레이닝을 갑니다!

doSomeThing(someone: jenny) // 등교를 합니다.

doSomeThing(someone: min) // 숨을 쉽니다.


