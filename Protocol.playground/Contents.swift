import UIKit

/* 프로토콜 */

// 프로토콜은 특정 역할을 수행하기 위한
// 메서드, 프로퍼티, 이니셜라이저 등의 요구사항을 정의한다.

// 구조체, 클래스, 열거형은 프로토콜을 채택(adopted)해서
// 프로토콜의 요구사항을 실제로 구현할 수 있다.
// 어떤 프로토콜의 요구사항을 모두 따르는 타입은
// 그 '프로토콜을 준수한다(Conform)'고 표현한다.
// 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 기능을
// 모두 구현해야 한다.

// MARK: - 정의 문법

/*
protocol 프로토콜 이름 {
    /* 정의부 */
}
*/

protocol Talkable{
    
    // 프로퍼티 요구
    // 프로퍼티 요구는 항상 var 키워드를 사용한다.
    // get은 읽기만 가능해도 상관 없다는 뜻이며
    // get과 set을 모두 명시하면
    // 읽기 쓰기 모두 가능한 프로퍼티여야 한다.
    var topic: String{get set}
    var language: String{get}
    
    // 메서드 요구
    func takl()
    
    // 이니셜라이저 요구
    init(topic: String, language: String)
}

// MARK: - 프로토콜 채택 및 준수

// Person 구조체는 Talkable 프로토콜을 채택했다.
struct Person: Talkable{
    var topic: String
    let language: String
    
    // 읽기전용 프로퍼티 요구는 연산 프로퍼티로 대체가 가능하다.
//    var language: String{ return "한국어" }
    
    // 물론 읽기, 쓰기 프로퍼티도 연산 프로퍼티로 대채할 수 있다.
    var subject: String = ""
//    var topic: String {
//        set{
//            self.subject = newValue
//        }
//        get{
//            return self.subject
//        }
//    }
    
    func takl() {
        print("\(topic)에 대해 \(language)로 말합니다.")
    }
    
    init(topic: String, language: String) {
        self.topic = topic
        self.language = language
    }
}

// MARK: - 프로토콜 상속

// 프로토콜은 클래스와 다르게 다중상속이 가능하다.
/*
 protocol 프로토콜 이름: 부모 프로토콜 이름 목록 { // 다중상속 가능!
    /* 정의부 */
}
*/

protocol Readable{
    func read()
}

protocol Writeable{
    func write()
}

protocol ReadSpeakable: Readable{
//    func read() // 쓰지 않아도 상관없다. 요구한다.
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable{
//    func read()
//    func write() // 마찬가지로 요구하고 있다고 볼 수 있다.
    func speak()
}

struct SomeType: ReadWriteSpeakable{ // 채택한 모든 프로토콜의 func를 따라야 한다.
    func read() {
        print("Read")
    }
    
    func write() {
        print("write")
    }
    
    func speak() {
        print("speak")
    }
}

// MARK: - 클래스 상속과 프로토콜

// 클래스에서 상속과 프로토콜 채택을 동시에 하려면
// 상속받으려는 클래스를 먼저 명시하고
// 그 뒤에 채택할 프로토콜 목록을 작성한다.
class SuperClass: Readable{
    func read() {
        print("read")
    }
}

class SubClass: SuperClass,Writeable,ReadSpeakable{ // 상속 클래스 먼저 써줘야한다.
    func write() {
        print("write")
    }
    
    func speak() {
        print("speak")
    }
}

// MARK: - 프로토콜 준수 확인
// 인스턴스가 특정 프로토콜을 준수하는지 확인할 수 있다.
// is, as 연산자 사용

let sup: SuperClass = SuperClass()
let sub: SubClass = SubClass()

var someAny: Any = sup
someAny is Readable // true
someAny is ReadSpeakable // false

someAny = sub
someAny is Readable // true
someAny is ReadSpeakable // true

someAny = sup

if let someReadable: Readable = someAny as? Readable{ // as? 로 캐스팅까지 완료한 후 사용
    someReadable.read()
} // read

if let someReadSpeakable: ReadSpeakable = someAny as? ReadSpeakable{
    someReadSpeakable.speak()
} // 동작하지 않음

someAny = sub

if let someReadable: Readable = someAny as? Readable{ // sub의 경우 readable을 따르는 superClass를 상속 받았기 때문에 readable을 따른다.
    someReadable.read()
} // read
