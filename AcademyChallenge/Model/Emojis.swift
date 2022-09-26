//
//  Emojis.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import Foundation
import UIKit
class Emojis {
	func getData(
		from url: URL,
		completion: @escaping (Data?, URLResponse?, Error?) -> ()
	) -> Void {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	
	func getDataNonEscaping(
		from url: URL,
		completion: (Data?, URLResponse?, Error?) -> ()
	) -> Void {
		if url.hasDirectoryPath {
			completion(nil, nil, nil)
		} else {
			
		}
	}
	
	func downloadImage(from url: URL) -> UIImage? {
		var image: UIImage?
		
		getData(from: url) { data, response, error in
			guard let data = data, error == nil else { return }
			print(response?.suggestedFilename ?? url.lastPathComponent)
			DispatchQueue.main.async() { () in
				//image = UIImage(data: data)
			}
		}
		
		//URLSession.shared.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
		
		return image
	}
}


func a() {
	let url = URL(string: "https://google.com")!
	Emojis().getData(from: url) { data, response, error in
		print("In Escaping closure")
	}
	print("checkpoint 1")
	Emojis().getDataNonEscaping(from: url) { data, response, error in
		print("In Non-Escaping closure")
	}
	print("checkpoint 2")
}

