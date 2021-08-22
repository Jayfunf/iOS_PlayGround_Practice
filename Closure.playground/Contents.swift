import UIKit

// 코드의 블럭
// 일급 시민(first-citizen) 이기에
// 변수, 상수 등으로 저장, 전달인자로 전달 가능
// 함수: 이름있는 클로저

// 함수의 사용
func sumNum(a: Int, b: Int) -> Int{
    return a+b
}

var result: Int = sumNum(a: 1, b: 2)

print(result) //3

// 클로저의 사용
var sum: (Int, Int) -> Int = {(a: Int, b: Int) -> Int in
    return a+b
}

result = sum(3,4)
print(result) //7

// MARK: - 함수의 전달인자로서의 클로저

let add:(Int, Int) -> Int
add = {(a: Int, b:Int) -> Int in
    return a+b
}
let sub:(Int, Int) -> Int
sub = {(a: Int, b:Int) -> Int in
    return a-b
}
let dev:(Int, Int) -> Int
dev = {(a: Int, b:Int) -> Int in
    return a/b
}

func calcul(a: Int, b:Int, method: (Int, Int)->Int)->Int{
    return method(a,b)
}

var calculated: Int

calculated = calcul(a: 50, b: 10, method: add)
print(calculated) // 60

calculated = calcul(a: 50, b: 10, method: sub)
print(calculated) // 40

calculated = calcul(a: 50, b: 10, method: dev)
print(calculated) // 5

//MARK: - 후행 클로저
// 클로저가 함수의 마지막 전달 인자라면
// 마지막 매개변수 이름을 생략한 후
// 함수 소괄호 외부에 클로저 구현

result = calcul(a: 10, b: 5) {(left: Int, right: Int)->Int in // method를 생략하고 소괄호 외부에 클로저 구현
    print(left+right)
    return left+right
}

//MARK: - 반환타입 생략

result = calcul(a: 10, b: 10) {(left: Int, right: Int) in // 반환타입 생략
    print(left+right)
    return left+right
}

//MARK: - 단축인자 이름
// in 도 생략 가능

result = calcul(a: 20, b: 5, method: { //method의 매개변수 목록이 없는데도 불구하고 값이 잘 나온다. $0,$1등으로 매개변수의 단축인자를 지정하여 사용.
    return $0+$1 //25
})

//MARK: - 암시적 반환 표현
// 이젠 하다하다 return까지 필요 없다. 위에서 우린 이미 반환 타입까지 지정해줬기 때문에 컴파일러가 알아서 반환할걸 알고 처리해준다.

result = calcul(a: 20, b: 20, method:{
    $0+$1 // 40
})
//more! more 간단!

result = calcul(a: 20, b: 25){
    $0+$1 // 45
}

// 미쳤다 이젠 그냥 한줄이다

result = calcul(a: 25, b: 25){$0+$1};print(result) //50

