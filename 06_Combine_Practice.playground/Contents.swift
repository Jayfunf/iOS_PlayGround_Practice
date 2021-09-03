import UIKit
import Combine

var myIntArrayPublisher: Publishers.Sequence<[Int],Never> = [1,2,3].publisher

//myIntArrayPublisher.sink(receiveCompletion: { Completion in
//    switch Completion {
//    case .finished:
//        print("Finished")
//    case .failure(let error):
//        print("Error : \(error)")
//    }
//}, receiveValue: { receivedValue in
//    print("Received: \(receivedValue)")
//})

var mySubscription: AnyCancellable? //구독자 생성

var mySubscriptionSet = Set<AnyCancellable>()

var myNotification = Notification.Name("com.dev.customNotification")

var myDefaultPublisher: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: myNotification)

mySubscription = myDefaultPublisher.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        print("finished")
    case .failure(let error):
        print("error: \(error)")
}
}, receiveValue: { receivedValue in
        print("received: \(receivedValue)")
})

mySubscription?.store(in: &mySubscriptionSet) // & -> 매개변수 자체를 변경할 수 업ㅆ는데 이건 가능?

NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))
NotificationCenter.default.post(Notification(name: myNotification))

//mySubscription?.cancel()

// KVO - Key Value Observing

class MyFriend {
    var name = "Jay"{
        didSet{
            print("name - didset() : ",name)
        }
    }
}

var myFriend = MyFriend()

var mrFriendSubscription: AnyCancellable = ["Insu"].publisher.assign(to: \.name, on: myFriend)
