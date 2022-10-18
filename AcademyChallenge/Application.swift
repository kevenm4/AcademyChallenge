//
//  Application.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 30/09/2022.
//

import Foundation


class Application {
	static var urlSession: URLSession?
	
	
	static func initialize() {
		let sessionConfiguration = URLSessionConfiguration.default
		sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		urlSession = URLSession(configuration: sessionConfiguration)
	}
}
