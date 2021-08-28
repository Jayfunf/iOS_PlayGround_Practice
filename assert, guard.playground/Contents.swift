import UIKit

/* assert와 guard*/

// 애플리케이션이 동작 도중에 생성하는 다양한 결과값을
// 동적으로 확인하고 안전하게 처리할 수 있도록
// 확인하고 빠르게 처리할 수 있다.

// MARK: - Assertion
// assert(_:_:file:line:) 함수를 사용한다.
// assert 함수는 디버깅 모드에서만 동작한다.
// 배포하는 애플리케이션에서는 제외된다.
// 주로 디버깅 중 조건의 검증을 위하여 사용한다.

var someInt: Int = 0

assert(someInt == 0, "someInt != 0") // 조건에 맞으면 assert를 지나치고 조건에 맞지 않으면 메세지를 출력하고 동작을 정지

someInt = 1

//assert(someInt == 0) // Error 발생

func functionWithAssert(age: Int?){
    
    assert(age != nil, "age == nil")
    
    assert((age! >= 0) && (age! <= 130), "나이값 입력이 잘못되었습니다.")
    print("당신의 나이는 \(age!)입니다.")
}

functionWithAssert(age: 50) // 당신의 나이는 50입니다.
//functionWithAssert(age: -1) // error
//functionWithAssert(age: nil) // error

// MARK: - Early Exit // 빠른 종료
// guard를 사용하여 잘못된 값의 전달 시
// 특정 실행구문을 빠르게 종료함.
// 디버깅 모드 뿐만 아니라 어떤 조건에서도 동작함.
// guard의 else 블럭 내부에는
// 특정 코드블럭을 종료하는 지시어(return, break 등)가
// 꼭 있어야 한다.
// 타입 캐스팅, 옵셔널과도 자주 사용된다.
// 그 외 단순 조건 판단후 빠르게 종료할 때도 용이한다.

func functionWithGuard(age: Int?){
    
    guard let unwrappedAge = age, // 옵셔널 바인딩과 연결해서 age의 옵셔널을 까봄 // age가 nil이라면 바로 리턴
          unwrappedAge < 130,
          unwrappedAge >= 0 else{ // guard에는 else가 꼭 들어가야한다. 여기서 nil이 들어와도 옵셔널 바인딩으로 걸러져 else에서 오류 메세지 출력 후 리턴
        print("나이값 입력이 잘못되었습니다.")
        return
    }
    
    print("당신의 나이는 \(unwrappedAge)입니다.") // if let 같은 경우 unwrapping한 값은 블럭 안에서만 사용 가능했지만 guard는 밑에서도 사용 가능
}

functionWithGuard(age: 50) // 당신의 나이는 50입니다.
functionWithGuard(age: -1) // 나이값 입력이 잘못되었습니다.
functionWithGuard(age: nil) // 나이값 입력이 잘못되었습니다.

var count = 1

while true{
    guard count < 3 else{ // 1, 2 까지는 guard를 지나쳐 값이 출력되고 3부턴 조건에 걸려 else를 따라 종료
        break
    }
    print(count)
    count+=1
} // 1 ... 2

func someFunction(info: [String: Any]){ // dictionary는 당연히 업셔널 타입이다.
    guard let name = info["name"] as? String else { // String 타입으로 캐스팅을 시도해서 완벽하게 동작하면 name으로 바인딩을 해서 값이 들어감
        return // 그렇지 않다면 return으로 빠르게 종료
    }
    
    guard let age = info["age"] as? Int, age >= 0 else { // 한번에 다 검증 가능. 편하다.
        return
    }
    
    print("\(name): \(age)")
}

someFunction(info: ["name": "jenny", "age":"10"]) // 나이가 Int가 아닌 비정상 값이라 값이 나오지 않음
someFunction(info: ["name": "mike"]) // 나이가 없기 때문에 바인딩, 캐스팅 모두 불가능하여 값이 나오지 않음
someFunction(info: ["name": "min", "age":10]) // 유일하게 값이 나옴. // min: 10
