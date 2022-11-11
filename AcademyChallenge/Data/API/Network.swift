//
//  Network.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 30/09/2022.
//

import Foundation
//
import RxSwift

 class Network {

	static func initialize() {
	 URLSession.shared.configuration.urlCache?.diskCapacity = 100 * 1024 * 1024
        print("disk cache capacity: \(String(describing: URLSession.shared.configuration.urlCache?.diskCapacity))")
 }

	func executeNetworkCall<ResultType: Decodable>
    (_ call: APIProtocol, _ resultHandler: @escaping (Result<ResultType, Error>) -> Void) {
		let decoder = JSONDecoder()
		var request = URLRequest(url: call.url)
		request.httpMethod = call.method.rawValue
		call.headers.forEach { (key: String, value: String) in
			request.setValue(value, forHTTPHeaderField: key)
		}

		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			if let data = data {
				if let result = try? decoder.decode(ResultType.self, from: data) {
					resultHandler(Result<ResultType, Error>.success(result))
				} else {
					resultHandler(Result<ResultType, Error>.failure(APIError.unknownError))
				}
			} else if let error = error {
				resultHandler(Result<ResultType, Error>.failure(error))
			}
		}

		task.resume()
	}
     func rxExecuteNetworkCall<ResultType: Decodable>(_ call: APIProtocol) -> Single<ResultType> {
         let decoder = JSONDecoder()
         var request = URLRequest(url: call.url)
         request.httpMethod = call.method.rawValue
         call.headers.forEach { (key: String, value: String) in
             request.setValue(value, forHTTPHeaderField: key)
         }

         return Single<ResultType>.create { single in
                 let task = URLSession.shared.dataTask(with: request) { data, _, error in
                     if let error = error {
                         single(.failure(error))
                         return
                     }
                     print("hello")
                     guard let data = data,
                           let result = try? decoder.decode(ResultType.self, from: data)
                     else {
                         single(.failure(APIError.unknownError))
                         return
                     }

                     single(.success(result))
                 }

                 task.resume()

                 return Disposables.create { task.cancel() }
             }
     }



 }
