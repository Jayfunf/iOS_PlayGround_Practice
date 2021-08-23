import UIKit

/*프로퍼티*/

//MARK: - 프로퍼티의 종류
// 구조 프로퍼티
// 연산 프로퍼티
// 인스턴스 프로퍼티
// 타입 프로퍼티

// 프로퍼티는 열거형, 구조체, 클래스 내에 구현할 수 있다.
// 다만 열거형 내부에는 연산 프로퍼티만 구현 가능
// 연산 프로퍼티는 var로만 구현 가능

struct Student{
    // 인스턴스 저장 프로퍼티
    // 흔히 알던 평범한 프로퍼티이다. 저장만을 위해 사용했음.
    var name: String = ""
    var `class`: String = "Swift" //`class`를 함수명으로 쓰기 위한 -> ``
    var koreanAge: Int = 0
    
    // 인스턴스 연산 프로퍼티
    var westernAge: Int{
        get{
            return koreanAge - 1 // 값을 꺼낼 때는 한국 나이에 - 1 을 하면 그게 곳 미국나이
        }
        set(value){
            koreanAge = value + 1 // 즉 westernAge를 만들 때는 westernAge에 + 1 을 해야 한국 나이라는 것.
        }
    }
    
    // 타입 저장 프로퍼티
    static var typeDescription: String = "학생"
    
    // 읽기전용 인스턴스 연산 프로퍼티
    // get만 구현하면 읽기 전용 프로퍼티임. 쓰기 전용은 없음.
    var selfIntro: String{
        get{
            print("저는 \(self.class)반 \(self.name) 입니다.")
            return "저는 \(self.class)반 \(self.name) 입니다."
        }
    }
    
    static var selfIntro:String{
        return "학생타입입니다."
    }
}

//MARK: - 사용

print(Student.selfIntro) //학생타입입니다.

var me:Student = Student()

me.name = "Jay5"
me.class = "Swift"
me.koreanAge = 23

me.selfIntro //저는 Swift반 Jay5 입니다.
me.westernAge //22

//MARK: - 응용

struct money{
    let currentMoney: Double = 1100
    var dollar:Double = 0
    
    var won:Double{
        get{
            return dollar*currentMoney
        }
        set{ // 들어올 매개변수를 지정하지 않아도 암시적으로 지정 가능
            dollar = newValue/currentMoney
        }
    }
}

var wallet: money = money()

wallet.won = 11000

print(wallet.dollar) //10.0

wallet.dollar = 15

print(wallet.won) //16500.0


//MARK: - 지역변수, 전역변수

var a: Int = 10
var b: Int = 10

var sum:Int{
    return a+b
}

print(sum) //20
// 프로퍼티를 연산
