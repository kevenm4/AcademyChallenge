//
//  UIImageView+Download.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/10/2022.
//

import UIKit


extension UIImageView {
	
	func downloadImageFromURL(from url: URL) {
			let task = URLSession.shared.dataTask(with: url){ data, response, error in
				if let data = data {
					if let image = UIImage(data: data) {
						DispatchQueue.main.async { [weak self] in
							self?.image = image
						}
					}
				} else if let error = error{
					print("UIImage Download ERROR: \(error)")
				}
			}
			task.resume()
		}
	}



