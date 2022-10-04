//
//  AvatarNetwork.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 03/10/2022.
//

import Foundation
import UIKit

enum AvatarAPI {
	case getAvatar
	case postAvatar
}


extension AvatarAPI: APIProtocol{
	var url: URL {
		URL(string: "https://api.github.com/users")!
	}
	
	var method: Method {
		switch self {
		case .getAvatar:
			return .get
		case .postAvatar:
			return .post
		}
	}
	
	var headers: [String : String] {
		["Content-Type": "application/json"]
	}
	
	
}


func executeNetwork<ResultType: Decodable>(_ call: APIProtocol, _ resultHandler: @escaping (Result<ResultType, Error>) -> Void) {
	let decoder = JSONDecoder()
	var request = URLRequest(url: call.url)
	request.httpMethod = call.method.rawValue
	call.headers.forEach { (key: String, value: String) in
		request.setValue(value, forHTTPHeaderField: key)
	}

	let task = URLSession.shared.dataTask(with: request) { data, response, error in
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


