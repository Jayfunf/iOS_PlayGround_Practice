import UIKit
import Combine

// MARK: - Subject
/*
 Subject는 Publsiher의 일종입니다.
 특별한 점은 파이프라인 외부에서도 파이프라인 안으로 데이터를 보낼 수 있습니다.
 외부에서 안으로 데이터를 주입시킬 수 있기 때문에 기존 Combine 프로토콜이 아닌 콜백 클로저로 구현되어있더라도 Subject를 이용하면 쉽게 리팩터링 할 수 있습니다.
 또한 SwiftUI처럼 다른 Framework와도 쉽게 연동하여 사용할 수 있습니다.
 
 Subject는 크게 PassthroughSubject과 CurrentValueSubject 두 가지의 빌트인 타입을 갖습니다.
 */

// MARK: - PassthroughSubject
/*
 상태값을 가지지않는 Subject입니다.
 Suject의 특성상 외부에서 안으로 데이터를 주입시킬 수 있기 때문에 기존 Combine 프로토콜이 아닌 콜백 클로저로 구현되어있더라도 쉽게 리팩토링해줄 수 있습니다.
 */
let subject = PassthroughSubject<String, Error>()

subject.sink(receiveCompletion: { completion in
  //에러가 발생한경우도 receiveCompletion 블록이 호출됩니다.
  switch completion {
  case .failure:
    print("Error가 발생하였습니다.")
  case .finished:
    print("데이터의 발행이 끝났습니다.")
  }
}, receiveValue: { value in
  print(value)
})

//데이터를 외부에서 발행할 수 있습니다.
subject.send("A")
subject.send("B")
//데이터의 발행을 종료합니다.
subject.send(completion: .finished)

// MARK: - CurrentValueSubject
//맨처음 초기값을 지정합니다.
let currentStatus = CurrentValueSubject<Bool, Error>(true)


currentStatus.sink(receiveCompletion: { completion in
  switch completion {
  case .failure:
    print("Error가 발생하였습니다.")
  case .finished:
    print("데이터의 발행이 끝났습니다.")
  }
}, receiveValue: { value in
  print(value)
})

//데이터를 외부에서 발행할 수 있습니다.
print("초기값은 \(currentStatus.value)입니다.")
currentStatus.send(false) //false 값을 주입합니다.
//value값을 변경해도 값이 발행됩니다.
currentStatus.value = true
/* result
 true
 초기값은 true입니다.
 false
 true
 */
// 상태값을 가지는 Subject로 주로 UI의 상태값에 따라 데이터를 발행할때 사용하기 유용합니다.

// MARK: - Cancellable
/*
 우리가 이전에 학습한 Subscriber는 Cancellable을 리턴 값으로 가집니다.
 Cancellable은 데이터 발행 중 cancel() 메서드가 호출되었을 때 모든 파이프라인이 멈추고 끝나게 됩니다.
 만약 사용자가 데이터 로딩을 기다리던도중 뒤로 간다거나 취소를 누른는경우처럼 스트림을 중단해야할때 사용될 수 있습니다.
 
 위에서 언급한 Subject에서 데이터를 발행하고 cancel 함수를 이용해서 데이터의 발행을 종료해보겠습니다.
 */
//Subejct 타입의 externalProvider를 초기화합니다.
let externalProvider = PassthroughSubject<String, Never>()


let anyCancleable = externalProvider.sink{ steam in
        print("전달받은데이터 \(steam)")
}


externalProvider.send("A")
externalProvider.send("B")
externalProvider.send("C")
anyCancleable.cancel() //데이터 발행을 중단합니다.
externalProvider.send("D")
/* result
 전달받은데이터 A
 전달받은데이터 B
 전달받은데이터 C
 */
// PassThoughSubject는 외부에서도 데이터를 발행할 수 있기 때문에 언제든 send 메서드를 이용해서 스트림으로 데이터를 전달할 수 있습니다.
// cancel이 호출된 이후에는 더 이상 데이터가 발행되지 않습니다.
