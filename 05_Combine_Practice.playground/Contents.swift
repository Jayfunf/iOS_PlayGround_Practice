import UIKit
import Combine

// MARK: - eraseToAnyPublisher
/*
 04번의 withCombine코드를 보면 뜬금없이 erastToAnyPublisher가 보입니다.
 Publisher가 아닌 AnyPublisher형태로 리턴해줍니다.
 eraseToAnyPublisher은 지금까지의 데이터 스트림이 어떠했던 최종적인 형태의 Publisher를 리턴합니다.
 아래 예를 들어보겠습니다.
 */

let x = PassthroughSubject<String,Never>()
    .flatMap{ name in
        return Future<String, Error> { promise in
            promise(.success(""))
    }.catch{ _ in
        Just("No user found")
    }.map { result in
        return "\(result) foo"
    }
}
/*
 위와 같은 PassthoughSubject는 PassthoughSubject에 FlatMap 오버 레이터를 사용하고 다시 에러 처리를 별도로 해주었습니다.
 만약 타입 형식으로 데이터를 받는다면 어떤 타입이 될까요? 수없이 많은 프로퍼티 래퍼가 들어갔기 때문에 아래와 같습니다.

//Publishers.FlatMap<Publishers.Map<Publishers.Catch<Future<String, Error>, Just<String>>, String>, PassthroughSubject<String, Never>>

 타입이 너무 긴 데다 개발자 입장에선 데이터 파이프라인이 어떤 흐름으로 연결되는지 외부에 노출됩니다.
 우리에게 중요한 건 Publsiher와 Operator의 결과로 Subscrbier가 받게 될 결괏값만이 중요합니다.
 
 let x = PassthroughSubject<String, Never>()
 //////////생략
 }.eraseToAnyPublisher()

 이제 x는 간단히 아래와 같은 타입이 됩니다.
 
 AnyPublisher<String, Never>
 
 Operation에서의 데이터를 처리할 땐 Operation 상호 간 에러 처리나 혹은 스트림 제어를 위해서 데이터 형식을 알아야 하지만 Subscrbier에게 전달될 땐 필요가 없게 됩니다.
 따라서 최종적인 형태로 데이터를 전달할 땐 eraseToAnyPublisher를 사용하게 됩니다.
 */

// MARK: - ErrorHandling
// .replaceError(with: [])

/*
 이전 코드에서는 replaceError를 이용하여 에러 스트림이 전달 안되도록 처리하였습니다.
 하지만 조금 더 상세한 에러 처리가 필요한 경우는 어떻게 해야 할까요?
 */
let cancellable = URLSession.shared.dataTaskPublisher(for: url)
    .tryMap { data, response -> Data in //성공해야만 데이터를 아래로 흘려보냅니다.
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
                //200데이터가 아니면 호출됩니다.
                throw NetworkErrorType.invalidServerResponse
        }
        return data
}
/*
 peration들 중 try가 붙는 Operator들은 대부분 블록 안에서 발생한 에러를 파이프라인 외부로 방출하지 않습니다.
 만약 하단에 catch나 retry Operator가 선언되어있다면 에러를 받아 적절히 처리할 수 있습니다.
 */
