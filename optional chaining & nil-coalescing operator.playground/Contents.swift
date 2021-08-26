import UIKit

// 옵셔널 체이닝은 옵셔널 내부의 프로퍼티로
// 또다시 옵셔널이 연속적으로 연결되는 경우 유용하게 사용할 수 있다.

class Person{
    var name: String
    var job: String?
    var home: Apartment?
    
    init(name: String) {
        self.name = name
    }
}

class Apartment{
    var buildingNumber: String
    var roomNumber: String
    var gyung: Person?
    var owner: Person?
    
    init(dong: String, ho: String) {
        buildingNumber = dong
        roomNumber = ho
    }
}

let min:Person = Person(name: "Min")
let apart:Apartment = Apartment(dong: "101", ho: "202")
let superman: Person = Person(name: "superman")

// 옵셔널 체이닝이 실행 후 결과값이 nil일 수 있으므로
// 결과 타입도 옵셔널이다.

// 만약 우리집 경비원의 직업이 궁금하다면...?

// 옵셔널 체이닝을 사용하지 않을 경우
func guardJob(owner:Person?){
    if let owner = owner{
        if let home = owner.home{
            if let gyung = home.gyung{
                if let guardJob = gyung.job{
                    print("우리집 경비원의 직업은 \(guardJob)입니다.")
                } else{
                    print("우리집 경비원은 직업이 없어요.")
                }
            }
        }
    }
}

guardJob(owner: min)

// 옵셔널 체이닝을 사용한다면,
func guardJobWithOptionalChaining(owner:Person?){
    if let guardJob = owner?.home?.gyung?.job{ // 한번에 연결하여 사용
        // owner? -> 사람(주인)이 있습니까? home? -> 집이 있습니까? guard? -> 경비원이 있습니까? / 모두 yes라면 job -> 직업 출력
        print("우리집 경비원의 직업은 \(guardJob)입니다.")
    } else{
        print("우리집 경비원은 직업이 없어요.")
    }
}

guardJobWithOptionalChaining(owner: min)

min.home?.gyung?.job // nil

min.home = apart

min.home?.gyung?.job // nil

min.home?.gyung = superman

min.home?.gyung?.name // "superman"
min.home?.gyung?.job // nil

min.home?.gyung?.job = "경비원"

guardJobWithOptionalChaining(owner: min) // 우리집 경비원의 직업은 경비원입니다.

// 체인처럼 물려있어서 옵셔널 체이닝.

// nil 병합 연산자
// ?? <- 이다. 앞의 값 87번의 min.home?...의 값이 nil이라면 ??뒤의 "슈퍼맨"의 값을 guardJob에 할당해달라!
var guardJob: String

guardJob = min.home?.gyung?.job ?? "슈펴맨"
print(guardJob) // 경비원

min.home?.gyung?.job = nil

guardJob = min.home?.gyung?.job ?? "슈펴맨"
print(guardJob) // 슈펴맨

// 닉네임 설정 시 사용자에게 넘겨받은 닉네임이 없다면 자동으로 nil 병합으로 지정?


