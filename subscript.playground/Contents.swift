import UIKit

// MARK: - subscript
// 컬렉션, 리스트, 시퀀스 타입의 개별 요소에 접근할 수 있는 지름길
// 다른 언어처럼 [index]로 접근 가능!

// 기본적으로 get, set 사용

// 예제1
struct Num{
    let num = [1,2,3,4]
    subscript(i: Int) -> Int{
        return num[i]
    }
}

var n = Num()
print(n) // Num(num: [1, 2, 3, 4])
print(n[0],n[1],n[2],n[3]) // 1 2 3 4

// 예제2
class MovieList{
    private var tracks = ["A", "B", "C"]
    subscript(index: Int) -> String{
        get{
            return self.tracks[index]
        }
        set{
            self.tracks[index] = newValue
        }
    }
}

var movielist = MovieList()

print("My favorite movie is \(movielist[1])") // My favorite movie is B
