import UIKit

//MARK - 게터, 세터
class Person{
    private var mAge: Int = 0
    private var mName: String? = nil
    
    //두 변수 모두 접근지시자가 private으로 선언하여 외부에서 변경할 수 없다.
    //따라서 게터, 세터로 값을 변경해야한다.
    
    var age: Int{
        set (value){ //변경할 값을 받고 self.mAge로 내부의 mAge의 값을 변경
            self.mAge = value
        }
        get {
            return mAge
        }
    }
    
    var name: String?{
        set (value){
            self.mName = value
        }
        get{
            return mName
        }
    }
    
    func intro(){
        print("Hi my name is \(mName!) and i'm \(mAge)") //mName!은 옵셔널이기 때문에 !를 붙이지 않으면 에러가 발생한다.
    }
}

var p = Person()

p.name = "Minhyun"

p.age = 23

p.intro()
