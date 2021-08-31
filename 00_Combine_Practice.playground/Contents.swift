import UIKit
import Combine

Just(5).sink{
    print($0)
} // 5

/*
 Just는 오직 하나의 값만을 출력하고 끝나게 되는 가장 단순한 형태의 Publisher로 Combine Framework에서 빌트인(Built-in) 형태로 제공하는 Publisher입니다.
 Just는 인자로 받는 값의 타입을 Output 타입으로 실패 타입은 항상 Never로 리턴합니다.
 sink는 클로저 형태로 데이터를 받는 Subscriber입니다. Input 타입으로는 클로저로 받게 되는 데이터 값을 에러 타입으로는 Never를 받습니다.
 */

let provider = (1...10).publisher

provider.sink(receiveCompletion: {_ in
    print("데이터 전달이 끝났습니다.")
}, receiveValue: {data in
    print(data)
}) // 1 2 3 4 5 6 7 8 9 10 데이터 전달이 끝났습니다.
/*
 sink에 receiveCompletion를 구현하여 데이터 스트림이 완료될 때 로그가 찍히도록 했다. provider 퍼블리셔는 1부터 10까지 데이터를 하나하나 발행하게 되고 sink로 연결될 때 구독(subscribe)이 시작됩니다.
 */

// reference: https://medium.com/harrythegreat/swift-combine-%EC%9E%85%EB%AC%B8%ED%95%98%EA%B8%B0-%EA%B0%80%EC%9D%B4%EB%93%9C-1-525ccb94af57
