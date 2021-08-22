import UIKit

//Constants and Variables
//var = 변경 가능한 변수
//let = 한 번 값이 할당되면 변경이 불가능한 상수
var version:Double = 1.0
var year = 2021
let languageName: String = "Swift"
let isAwesome: Bool = true

//Type Inference
//Swift의 특징으로 타입추론이 가능하다.
//타입추론이란 할당되는 value를 통해 변수의 타입을 예측하는 것을 의미한다.
var version2 = 1.0
var year2 = 2021
let languageName2 = "Swift"
let isAwesome2 = true

//Unicode Names
//Swift는 유니코드문자를 변수이름으로 사용 가능하다.
//이모티콘으로도 변수이름을 지을 수 있다. 아주 재미있는 기능인듯;
let π = 3.1415927
let 😼 = "cat"

//String
let someString = "I appear to be a string"

//Character
//5번의 고양이가 나온다.
//for-each 구문을 통해 문자열을 이루는 문자(character)를 간편하게 순회 가능
for character in "😼😼😼😼😼"{
    print(character)
}

//String Interpolation
//result = "3times 5 is 15"
let a = 3, b = 5
let mathResult = "\(a) times \(b) is \(a*b)"

//String mutability
var variableString = "latte is"
variableString += " horse"
print(variableString) //라떼는 말이야!

let constantString = "honey"
//constantString+="dog" // let 상수라 추가 불가능ㅜ 개꿀

//Array and Dictionary
//names는 Array
//numberOfLegs는 Dictionaly
var names = ["Messi", "Jotdo","Aguero"]
var numberOfLegs = ["ant":6, "snake":0, "cat":4, "me":3] // wait... 3legs? 😏
print(numberOfLegs.keys) //"["cat", "ant", "snake", "me"]\n"
print(numberOfLegs.values) //"[4, 6, 0, 3]\n"

//Loops

//for-in:ranges
for number in 1...5{ //1부터 5포함
    print(number) //1,2,3,4,5 출력
}

for number2 in 0..<5{ //0부터 5미포함
    print(number2) //0,1,2,3,4 출력
}

//For-in Array
for name in ["Messi", "Jotdo","Aguero"]{
    print(name)
}
//위에서 사용한 numberOfLegs 사용
for(animalName, legCount) in numberOfLegs{
    print("\(animalName)'s have \(legCount) legs")
}
//cat's have 4 legs
//ant's have 6 legs
//snake's have 0 legs
//me's have 3 legs

//Optionals
let  possibleLegcount: Int? = numberOfLegs["min"]
if possibleLegcount == nil{
    print("Not Found")
}
else{
    let legCount = possibleLegcount
    print("An min has \(legCount) legs")
}
//result: "Not Found"

//Unwrapping an Optuonal
//Optional로 선언된 변수는 그냥 사용할 수 없다.
//컴파일 에러에서 벗어나기 위해 optional 타입을 unwrapping 해야한다.

/*class Person{
    let name: String
    init(name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    deinit{
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")

reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
//여기 까지는 deinitialized가 출력되지 않는다.
//ref1과 ref2는 참조가 끊겼지만 아직 ref3이 참조되고 있기 때문이다.


reference3 = nil
//이렇게 ref3까지 끊으면 비로소 deinitialized가 출력된다.
*/
let insu: Bool? = true
var istrue: Bool = false

if let isinsu = insu{
    istrue = true
}else{
    istrue = false
}
print(istrue)

class Person{
    let name: String
    init(name: String){self.name = name}
    var apartment: Apartment?
    deinit{
        print("\(name) is being deinitialized")
    }
}
class Apartment{
    let unit: String
    init(unit: String){self.unit = unit}
    weak var tenant: Person?
    deinit{
        print("Apartment \(unit) is being deinitialized")
    }
}

var John: Person?
var unit6: Apartment?

John = Person(name: "John Appleseed")
unit6 = Apartment(unit: "6")

John!.apartment = unit6
unit6!.tenant = John

John = nil
unit6 = nil
//강한 참조를 끊어도 서로 참조하고 있기 때문에
//deinitialized가 출력되지 않는다.


class Customer{
    let name: String
    var card: CreditCard?
    init(name: String){
        self.name = name
    }
    deinit{ print("\(name) is being deinitialized")}
}
class CreditCard{
    let number: UInt64
    unowned let customer: Customer?
    init(number: UInt64, customer:Customer){
        self.number = number
        self.customer = customer
    }
    deinit{ print("Char #\(number) is being deinitialized")}
}

var john: Customer?

john = Customer(name: "Jhon Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

john = nil


protocol Sendable{
    var from: String? {get}
    var to: String{get}

    func send()
}

struct Mail: Sendable{
    var from: String?
    var to: String
    
    func send() {
        print("Send a mail from \(self.from) to \(self.to)")
    }
}
struct Feedback: Sendable {
    var from: String?{
        return nil
    }
    var to: String
    
    func send() {
        print("Send a feedback to \(self.to)")
    }
}

func sendAnything(_ sendable: Sendable) {
  sendable.send()
}

let mail = Mail(from: "simh3077@gmail.com", to: "simh3077@ajou.ac.kr")
sendAnything(mail)

let feedback = Feedback(to: "simh3077@gmail.com")
sendAnything(feedback)

func hello(name: String){
    print("Hello, \(name)")
}
hello(name: "Jayfunf")

func hello2(_ name: String){
    print("Hello2, \(name)")
}
hello2("Jayfunf")

var tuple_test = ("Americkii", 4200)

print(tuple_test.0)

print(tuple_test.1)

let (coffee, price) = ("latte", 5000)

print(coffee, price)

let (size, test) = (500,1000)

print(size,test)

let (_, sub, lik) = (5000, 1.0,5000)


class myClass{
    class func classFunc(){
        print("Class_Func")
    }
    static func staticFunc(){
        print("Static_Func")
    }
}

class mysubClass: myClass{
    override class func classFunc() {
        
    }
    /*override static func staticFunc(){
        
    }*/
}

func sum(A:Int, B:Int) -> Int{
    return A+B
}

sum(A: 3, B: 5)

func sum2(A:Int, B:Int) -> Void{
    print(A+B)
    return
}
sum2(A: 2, B: 3)


var x: Int8 = 25
var h = 10

//var xh = x*h //error about Int8, Int

let x2 = UInt8(25)

//let h = 10 * x2

let start: String? = "abcde"

//let start2 = start[start.startIndex]


if let startString = start{
    print(startString)
}

let array: [String?] = []

let isArrayEmpty = array.isEmpty == true

let email: String? = "simh@gmail.com"
let email2: String? = "simh@gmail.com"

print(email)
print(email!)
print(email2!)

typealias plus = Int
class Counter{
    private var count: Int = 0
    
    func countplus(target: Int, plusplus: plus){
        count += target*plusplus
    }
    
    func outcount() -> Int{
        print(count)
        return count
    }
}

var counter = Counter()

counter.countplus(target: 2, plusplus: 4)

counter.outcount()


class Counter2: Counter{
    private var target2: Int? = 30
    override func countplus(target: Int, plusplus: plus) {
        target2! += target+plusplus
    }
    
    override func outcount() -> Int {
        print(target2!)
        return target2!
    }
}

var counter2 = Counter2()

counter2.countplus(target: 5, plusplus: 5)

counter2.outcount()



