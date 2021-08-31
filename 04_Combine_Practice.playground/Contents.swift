import UIKit
import Combine

/* 더미데이터(JSON Placeholder)를 이용한 통신 */

// MARK: - Combine없이 작성하기
enum HTTPErrorWithoutCombine: LocalizedError{
    case statusCode
    case post
}

struct PostWithoutCombine: Codable{
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    
    // 에러가 발생할 경우의 분기처리
    if let error = error{
        fatalError("Error: \(error.localizedDescription)")
    }
    
    // 상태코드의 분기처리
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        fatalError("Error: invalid HTTP response code")
    }
    
    // 데이터의 분기처리
    guard let data = data else{
        fatalError("Error: missing response data")
    }
    
    //JSON 맵핑
    do{
        let decoder = JSONDecoder()
        let posts = try decoder.decode([PostWithoutCombine].self, from: data)
        print(posts.map{$0.title})
    }
    catch{
        print("Error: \(error.localizedDescription)")
    }
}
task.resume()



// MARK: - Combine으로 작성하기
enum HTTPErrorWithCombine: LocalizedError{
    case statusCode
    case post
}

struct PostWithCombine: Codable{
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

//let urlW = URL(string: "https://jsonplaceholder.typicode.com/posts")! // 위에 이미 선언함.

// dataTaskPublisher는 URLSession에서 제공하는 Publisher입니다.
let cancellable = URLSession.shared.dataTaskPublisher(for: url)
    .map{$0.data}
    .decode(type: [PostWithCombine].self, decoder: JSONDecoder()) // 존달받은 데이터를 JSON형식으로 Decode합니다.
    .replaceError(with: []) // 에러가 발생할 경우 에러를 전달하지 않습니다.
    .eraseToAnyPublisher()
    .sink(receiveValue: {posts in
        print("전달받은 데이터는 총 \(posts.count)개 입니다.")
    })
