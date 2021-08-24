import UIKit

// MARK: - inheritance - 상속
/*
 스위프트의 상속은 클래스, 포로토콜 등에서 가능
 enum, struct는 사용 불가능
 스위프트는 다중상속을 지원하지 않음
 */

// MARK: - 클래스의 상속과 재정의

/*
 class 이름: 상속받을 클래스 이름{
    /* 구현부 */
 }
 */

class Person{
    var name: String = ""
    
    func selfIntro(){
        print("저는 \(name)입니다.")
    }
    
    // final로 재정의 방지, final 즉 마지막 사용 정도
    // 자식 클래스가 override 할 수 없다는 뜻
    final func sayHello(){
        print("Hello")
    }
    
    // static으로 타입 매소드 선언
    // 재정의 불가
    static func typeMethod(){
        print("type MEthod - static")
    }
    
    // 재정의 가능 타입 메소드 - class
    class func classMethod(){
        print("class MEthod - class")
    }
    
    // 재정의 가능한 class 메서드라도
    // final 키워드를 사용하면 재정의 불가능.
    // 메소드 앞의 'static'과 'final class'는 똑같은 역할임
    // static == final class = true
    final class func finalClassMethod(){
        print("type MEthod - final class")
    }
    
    // MARK: - 일반 func과 class func의 차이
    
    
    // 두 func모두 자식클래스에서 오버라이드가 가능하다는 공통좀이 존재한다.
    // 차이점은 일반 func은 객체가 없으면 사용할 수 없다. 하지만 class func은 가능하다.
    // 예를 들어 Person.selfIntro()는 에러가 발생한다. 하지만 Person.classMethod()는 호출이 가능하다.
    // 91, 92 코드를 확인하자.
}

class Student: Person{
    var major: String = ""
    
    override func selfIntro() {
        //print("나는 \(name)이고, 전공은 \(major)이다.") // 함수 오버라이드로 재 정의
        // 만약 부모 클래스의 selfIntro() 함수를 불러오고 싶다면 super사용
        // super.selfIntro()
    }
    
    override class func classMethod() {
        print("overriden type method - class")
    }
    
    // static을 사용한 타입 메소드는 재정의 할 수 없다.
    // override static func typeMethod() // Error!
    // final 로 선언한 메소드들도 마찬가지이다.
    
}

let min: Person = Person()
let jiho: Student = Student()

min.name = "min" // 저는 min입니다.
jiho.name = "jiho" // 나는 jiho이고, 전공은 상경이다.
min.selfIntro()
jiho.major = "상경"
jiho.selfIntro()
min.sayHello() // Hello
jiho.sayHello() // Hello

jiho.selfIntro()

//Person.selfIntro() // 일반 func // Error: Instance member 'selfIntro' cannot be used on type 'Person'; did you mean to use a value of this type instead?
Person.classMethod() // class func
