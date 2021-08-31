import UIKit
import Combine

class CustomSubscriber: Subscriber{
    
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

let publisher = ["A","B","C","D","E","F","G"].publisher

let subscriber = CustomSubscriber()

publisher.subscribe(subscriber)
/* result
 데이터의 구독을 시작합니다.
 데이터를 받았습니다. A
 데이터를 받았습니다. B
 데이터를 받았습니다. C
 데이터를 받았습니다. D
 데이터를 받았습니다. E
 데이터를 받았습니다. F
 데이터를 받았습니다. G
 모든 데이터의 발행이 완료되었습니다.
 */
