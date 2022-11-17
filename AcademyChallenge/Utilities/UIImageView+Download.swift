//
//  UIImageView+Download.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 04/10/2022.
//

import UIKit
//
import Alamofire
import RxCocoa
import RxSwift

func downloadTask(url: URL, placeholder: UIImage = UIImage()) -> Observable<UIImage> {
    guard let request = try? URLRequest(url: url, method: .get)else { return
        Observable.just(placeholder) }
    return URLSession.shared.rx.response(request: request)
        .map { (response: HTTPURLResponse, data: Data) -> UIImage in
            guard
                response.statusCode == 200,
                let mimeType = response.mimeType, mimeType.hasPrefix("image"),
                let image = UIImage(data: data)
            else { return placeholder }
            return image
        }
}

extension UIImageView {
    func downloadImage(from url: URL) -> Disposable {
        return downloadTask(url: url)
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] image in
                self?.image = image
                // self?.contentMode = mode
            })
            .subscribe()
    }
    func downloadImageFromURL(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            } else if let error = error {
                print("UIImage Download ERROR: \(error)")
            }
        }
        task.resume()
    }
}
