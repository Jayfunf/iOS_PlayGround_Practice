import UIKit
import Combine
import Foundation

class CustomSubscrbier: Subscriber{
    func receive(completion: Subscribers.Completion<Never>) {
        print("모든 데이터의 발행이 완료되었습니다.")
    }
    
    func receive(subscription: Subscription) {
        print("데이터의 구독을 시작합니다.")
        
        subscription.request(.max(2)) // unlimited로 된 설정을 바꾸어 구독받을 데이터의 수를 변경할 수 있다.
        // 만약 .max(2)로 바꾼다면 구독의 최대수를 2개로 제한할 수 있다. 그렇다면 result는
        /*
         데이터의 구독을 시작합니다.
         데이터를 받았습니다. A
         데이터를 받았습니다. B
         */
        
        // 모든 데이터가 발행되지 않았기 때문에 completion는 호출되지 않는다.
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("데이터를 받았습니다.", input)
        // 구독 도중 데이터를 unlimited로 바꿔주면 이전의 설정을
        // 무시하고 모두 구독하게된다.
        return .none
    }
    
    typealias Input = String // 성공타입
    typealias Failure = Never // 실패타입
}

let formatter = NumberFormatter()
formatter.numberStyle = .ordinal
(1...10).publisher.map{
    formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
}.sink{
    print($0)
}
/* result
 1st
 2nd
 3rd
 4th
 5th
 6th
 7th
 8th
 9th
 10th
 */

// Operator는 생성자와 소비자 중간에 위치하여 데이터 스트림을 가공해주는 역할을 한다. 중간에 위치하여 데이터를 가공하여 보내줄 수 있다.

// Operator의 종류는 매우 많다. 대표적으로
/*
 Mapping Element:
 주로 데이터를 다른 데이터 타입으로 변경하는 역할
 Ex) scan, setFailurType, map, flatMap
 
 Filtering Element:
 조건에 맞는 데이터만 허용
 Ex) compactMap, replaceEmpty, filter, replaceError, removeDuplicates
 
 Reduce Element:
 데이터 스트림을 모아 출력
 Ex) collect, reduce, tryReduce, ignoreOutput
 
 Mathematic operations on elements
 숫자시퀸스값과 관련된 스트림을 제어
 Ex) max, count, min
 
 Sequence Elements
 데이터 시퀸스를 변형할 때 사용
 Ex) prepend, firstWhere, tryFirstWhere, first, lastWhere, tryLastWhere, lastm dropWhile
 */

