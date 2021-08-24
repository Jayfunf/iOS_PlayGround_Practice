import UIKit

// 알아도 다시 한 번...
// 미워도 다시 한 번...

// MARK: - collectionType
// Array, Dictionary, Set

/*
 Array - 순서가 있는 리스트 컬렉션
 Dictionary - 키와 값의 쌍으로 이루어진 컬렉션
 Set - 순서가 없고, 멤버가 유일한 컬렉션
 */

// MARK: - Array

// 빈 Int Array 생성
var array: Array<Int> = Array<Int>() // 정석

// append() 값 추가
array.append(1)
array.append(2)
array.append(3)

// contains() 값 찾기 return Bool
array.contains(3)
array.contains(4)

array.remove(at: 0) // 0번째 요소 제거
array.removeLast() // 마지막 제거
array.removeAll() // 다 제거

// array 축약 표현
var doubles_1: [Int] = [Int]()
var doubles_2: [Int] // ❤️
var doubles_3: [Int] = []
var doubles_4: Array<Int> = [Int]()
// ... 많기도 하다

// MARK: - Dictionary

var anyDictionary: Dictionary<String, Any> = Dictionary<String,Any>()
anyDictionary["Coffee"] = "Americano"
anyDictionary["Price"] = 4100
print(anyDictionary) // ["Coffee": "Americano", "Price": 4100]

// 딕셔너리 값 변경
anyDictionary["Coffee"] = "Latte" // 나때느.ㄴ...
print(anyDictionary) // ["Coffee": "Latte", "Price": 4100]

// 삭제
anyDictionary.removeValue(forKey: "Price")
print(anyDictionary) // ["Coffee": "Latte"]

// 또 다른 삭제
anyDictionary["Coffee"] = nil
print(anyDictionary) // [:]

// 축약형
let emptyDic:[String: String] = [:]
let newDic:[String: String] = ["Coffee": "Americano"]

// 옵셔널
// let someValue: String = newDic["Coffee"]
// 위 코드는 불가능하다. 값이 없을 수 있기 때문에 밑의 코드처럼 옵셔널로 선언해야 한다.
let someValue: String? = newDic["Coffee"]
print(someValue) // Optional("Americano")
print(someValue!) // Americano

// MARK: - Set
// Set은 축약 문법이 없다.

var integerSet: Set<Int> = Set<Int>()
integerSet.insert(1)
integerSet.insert(100)
integerSet.insert(99)
integerSet.insert(99)
integerSet.insert(99)

print(integerSet) // [1, 100, 99] 같은 값은 하나로. 중복이 없다.

// remove, removeFirst 등의 함수는 동일하게 작동한다.

// Set의 응용
let setA: Set<Int> = [1,2,3,4,5]
let setB: Set<Int> = [3,4,5,6,7]

let union: Set<Int> = setA.union(setB) // 합집합
print(union) // [2, 7, 6, 5, 1, 4, 3]

let sortedUnion: [Int] = union.sorted() // 정렬
print(sortedUnion) // [1, 2, 3, 4, 5, 6, 7]

let intersection: Set<Int> = setA.intersection(setB) // 교집합
print(intersection) // [5, 3, 4]

let subtraction: Set<Int> = setA.subtracting(setB) // 차집합
print(subtraction) // [1, 2]
