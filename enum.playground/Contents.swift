import UIKit

// enum... 이넘!!이넘아!!
// 열거형은 스위프트에서 중요하다. 많이 익혀두자..
//MARK: 정의

enum Week{
    case mon
    case tue
    case wed
    case thu, fri, set, sun
}

var day: Week = Week.mon //day의 type을 열거형 week로 지정
day = .tue //day의 type이 week이기 때문에 .으로 접근 가능

print(day) //tue

// switch문과 자주 사용

switch day{
case .mon, .tue, .wed, .thu:
    print("평...일...")
case .fri:
    print("불!!금!!")
case .set, .sun:
    print("주!!!!말@@@")
} // 이렇게 enum의 모든 부분을 작성하면 default를 작성할 필요가 없지만, 하나라도 빠진다면 default를 구현 해야함.

// MARK: 원시값

// c언어처럼 숫자도 넣어줄 수 있다. 이를 원시값이라고 한다.
// 이 숫자를 rawValue라고 한다.
// 꼭 숫자가 아니더라도 String등도 가능하다.
enum fruit: Int{
    case apple = 1
    case banana = 2
    case orange
}// apple의 rawValue가 1이면 뒤의 케이스들은 rawValue를 적어주지 않아도 자동으로 1씩 증가한다. 밑을보면...
print("\(fruit.orange.rawValue)") //아무것도 적지 않은 오렌지의 rawValue가 3으로 출력된다.
// 즉 시작 부분의 숫자부터 1씩 증가한다.
// 단 숫자는 자동으로 달리지만 만약 String이 원시값이라면 그냥 케이스의 이름이 출력되어 나온다.

// MARK: 원시값을 통한 초기화
// rawValue를 통해 초기화를 할 수 있다.
// rawValue가 case에 해당하지 않을 수 있으므로
// rawValue를 통해 초기화 한 인스턴스는 옵셔널 타입이다.

//let apple: fruit = fruit(rawValue: 5) // 오류 발생, case가 없을 수 있기 때문에 옵셔널로 선언해야 한다.
let apple: fruit? = fruit(rawValue: 5) // 옵셔널로 받으면 정상적으로 작동한다.

if let orange: fruit = fruit(rawValue: 3){ //만약 오렌지의 rawValue가 3이면 참, 3이 아니면 거짓.
    print("rawValue 3에 해당하는 과일은 \(orange) 입니다.")
}else{
    print("rawValue 3에 해당하는 과일이 없습니다.")
}

// MARK: 열거형 메소드
// 열거형 안에 메소드 생성 가능

enum Month{
    case jan, feb, mar
    case apr,may,jun
    case jul,aug,sep
    case oct,nov,dec
    
    func printmsg(){
        switch self { // 내부에서 끌어오니까 self
        case .mar, .apr, .may:
            print("Spring")
        case .jun, .jul, .aug:
            print("Summer")
        case .sep, .oct, .nov:
            print("Authom")
        case .dec,.jan,.feb:
            print("Winter")
        }
    }
}

Month.mar.printmsg() // spring출력
Month.dec.printmsg() // winter출력
