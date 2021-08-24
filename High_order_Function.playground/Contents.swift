import UIKit

// 고차함수
// map, filter, reduce가 있다.

// MARK: - MAP
// 컨테이너 내부의 기존 데이터를 변형하여 새로운 컨테이너 생성

let numbers:[Int] = [1,2,3,4,5] //고차함수의 타깃
var doubleNumbers:[Int]
var strings: [String]

doubleNumbers = numbers.map({(number: Int) -> Int in
    return number * 2
})

strings = numbers.map({(number: Int) -> String in
    return "\(number)"
})


print(doubleNumbers) // [2, 4, 6, 8, 10]
print(strings) // ["1", "2", "3", "4", "5"]
//축약도 가능하다.

var doubleNumbers_short:[Int]
var strings_Short:[String]

doubleNumbers_short = numbers.map({$0 * 2})
strings_Short = numbers.map({"\($0)"})

print(doubleNumbers_short) // [2, 4, 6, 8, 10] 같은 결과가 나온다/
print(strings_Short) // ["1", "2", "3", "4", "5"]

// MARK: - filter
// 컨테이너 내부의 값을 걸러서 새로운 컨테이너로 추출

// MARK: - for 구문 사용
// filter를 사용하지 않는다면,
var filtered: [Int] = [Int]()

for number in numbers{
    if number % 2 == 0{
        filtered.append(number)
    }
}

print(filtered) // [2, 4]

// MARK: - filter의 사용

let evenNumbers:[Int] = numbers.filter{
    (number: Int) -> Bool in
    
    return number % 2 == 0
}

print(evenNumbers) // [2, 4]

let evenNumbers_short:[Int] = numbers.filter({($0 % 2) == 0})

print(evenNumbers_short) // [2, 4]

// MARK: - reduce
// 컨테이너 내부의 콘텐츠를 하나로 통합

let someNumbers: [Int] = [2, 4, 8]

// for문을 사용한다면,
var result: Int = 0

for number in someNumbers{
    result += number
}

print(result) // 14

// reduce를 사용한다면,

var sum: Int = someNumbers.reduce(0, {(first: Int, second: Int) -> Int in
    
    return first+second
})

print(sum) // 14

var subtract: Int = someNumbers.reduce(0, {(first: Int, second: Int) -> Int in
    
    return first - second
})

print(subtract) // -14

// 축약

let sumFromeThree = someNumbers.reduce(3){$0 + $1} // 초깃값이 3이며 나머지 모든 숫자 더하기

print(sumFromeThree) // 17 (14에서 초깃값 3까지 더한 값)

let subFromThree = someNumbers.reduce(3){$0-$1}

print(subFromThree) // -11 (-14에서 초깃값 3을 뺀 나머지 값)
