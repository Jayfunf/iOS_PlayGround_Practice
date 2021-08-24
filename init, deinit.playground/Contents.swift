import UIKit

// 인스턴스 생성과 소멸

// 이니셜라이저와 디이니셜라이저
// init, deinit

// MARK: - 프로퍼티 기본 값

/*
 스위프트의 모든 인스턴스는 초기화와 동시에
 모든 프로퍼티에 유효한 값이 할당되어 있어야 한다.
 
 프로퍼티에 미리 기본값을 할당해두면
 인스턴스가 생성됨과 동시에 초기값을 지니게 된다.
 */

class PersonA{
    var name: String = "unknown"
    var age: Int = 0
    var nickName: String = "Jay"
} // 프로퍼티에 기본값을 넣어두지 않는다면 오류가 발생한다.

let jason: PersonA = PersonA() //이니셜라이즈
jason.age = 20
jason.name = "Jason Cho"
jason.nickName = "jason"

class PersonB{
    var name: String
    var age: Int
    var nickName: String
    
    init(name: String, age: Int, nickName: String){
        self.name = name
        self.age = age
        self.nickName = nickName
    }
}

let hana: PersonB = PersonB(name: "Hana Kim", age: 23, nickName: "hama") // 일반적인 인스턴스 프로퍼티 값 할당과 다르다.

print(hana.name)
print(hana.nickName)
print(hana.age)

// MARK: - 프로퍼티의 초기값이 꼭 필요 없을 때
// 예를 들어 이름, 나이는 있지만 닉네임이 없는 경우
// 옵셔널을 사용하라!

class PersonC{
    var name:String
    var age:Int
    var nickName:String?
    
    convenience init(name: String, age: Int, nickName: String){
        self.init(name: name, age: age)
        self.nickName = nickName
    }
    
    /*init(name:String, age:Int, nickName:String) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }*/
    
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    
    // 위의 init이 두 개 선언되며 self.name과 self.age가 중복된다. 이를 조금이나마 줄이려먼 convenience init을 사용하면된다.
}

// 같은 PersonC로 두 개의 init 가능
let jenny: PersonC = PersonC(name: "janny", age: 30)
let mike: PersonC = PersonC(name: "Mike", age: 12, nickName: "Miky")

/*
 암시적 추출 옵셔널은
 인스턴스 사용에 꼭 필요하지만
 최기값을 할당하지 않고자 할 때 사용
 */

class Puppy {
    var name: String
    var owner: PersonC! // 위에서 말한대로 해당 owner가 꼭! 필요할 때 찍어줌
    
    init(name: String) {
        self.name = name
    } // name만 초기화를 하는 이유는 이니셜라이즈할 때, 전달되기 어려운 값인 경우 일단 이름만 받고 나중에 owner를 세팅 하겠다! 이게 ! <- 임
    
    func goOut(){
        print("\(name)가 주인 \(owner.name)과 함께 산책을 합니다")
    }
}

let happy: Puppy = Puppy(name: "Happy")

//happy.goOut() // Error 발생. 꼭 들어가야하는 owner를 할당하지 않았기 때문, 즉 owner를 먼저 지정하고 나서 메소드를 실행해야함.
happy.owner = jenny // jenny는 위헤서 PersonC로 할당받은 PersonC 인스턴스
happy.goOut() // Happy가 주인 janny과 함께 산책을 합니다 -> 정상작동

// MARK: - 실패가능한 이니셜라이저
// 이니셜라이저 매개변수로 전달되는 초기값이 잘못된 경우
// 인스턴스 생성에 실패할 수 있다.
// 인스턴스 생성에 실패하면 nil을 반환한다.
// 그래서 실패가능한 이니셜라이저의 반환타입은 옵셔널 타입이다.

class PersonD{
    var name: String
    var age: Int
    var nickName: String?
    
    init?(name: String, age: Int){
        if(0...120).contains(age) == false{ // 나이가 0세부터 120세가 아니라면 return nil
            return nil
        }
        
        if name.count == 0{ // 이름의 갯수가 0이라면 return nil
            return nil
        }
        
        self.name = name
        self.age = age
    }
}

//let john: PersonD = PersonD(name: "john", age: 23) //옵셔널 타입의 init이기 때문에 타입에 옵셔널? 를 붙히지 않으면 오류가 발생한다. 밑의 코드처럼 해야함.
let john: PersonD? = PersonD(name: "john", age: 23)
let nim: PersonD? = PersonD(name: "nim", age: 123) // nil일 것이다.
let joker: PersonD? = PersonD(name: "", age: 23) // nil일 것이다.

print(nim) // nil
print(joker) // nil

// MARK: - 디이니셜라이저

/*
 deinit은 클래스의 인스턴스가
 메모리에서 해제되는 시점에 호출된다.
 인스턴스가 해제되는 시점에 해야할 일을 구현할 수 있다.
 
 deinit은 클래스 타입에만 구현을 할 수 있다.
 */

class PersonE{
    var name: String
    var pet: Puppy?
    var child: PersonC
    
    init(name:String, child: PersonC) {
        self.name = name
        self.child = child
    }
    
    /*
     아래의 코드를 해석하자면, 위의 PersonC의 인스턴스 child가 강아지 pet을 가지고 있다.
     그런데 이 사람이 deinit될 때, 만약 세상을 떠났다고 가정하면 강아지를 새 주인에게 양도해야 할 것이다.
     if let petName = pet?.name -> 만약에 강아지를 키우고 있는 상태라면
     self.pet?.owner = child -> 강아지 pet의 주인은 새 주인 즉 child 이다.
     */
    deinit { // deinit은 매개변수를 갖을 수 없다.
        if let petName = pet?.name{
            print("\(name)가 \(child.name)에게 \(petName)을 인도합니다.")
            self.pet?.owner = child
        }
    }
}

var donald: PersonE? = PersonE(name: "donald", child: jenny)
donald?.pet = happy
donald = nil // donald 인스턴스가 더이상 필요없으므로 메모리에서 해제 즉, 사망
// donald가 jenny에게 happy를 인도한다.
