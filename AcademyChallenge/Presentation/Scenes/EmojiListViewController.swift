//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit
//
import RxSwift

public protocol EmojiListViewControlerDelegate: AnyObject {
    func navigateToFirstPage()
}

class EmojiListViewController: BaseGenericViewController<EmojiView> {
    public weak var delegate: EmojiListViewControlerDelegate?
    var emoji: [Emoji]?
    var viewModel: EmojiListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        genericView.collectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.getEmojisList()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { emojis in
                
                self.emoji = emojis
                self.genericView.collectionView.reloadData()
            },
                       onFailure: { error in
                
                print("[GetEmojisList-ViewModel] \(error)")
            },
                       onDisposed: {
                print("GOOOOOOO")
                
            })
            .disposed(by: disposeBag)
    }
    //    override func viewDidDisappear(_ animated: Bool) {
    //        super.viewDidDisappear(animated)
    //        self.delegate?.navigateToFirstPage()
    //    }
}

extension EmojiListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let countEmojis = emoji?.count ?? 0
        return countEmojis
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let url = emoji?[indexPath.row].imageUrl else {return UICollectionViewCell()}
        viewModel?.imageAtUrl(url: url)
            .asOptional()
            .subscribe(cell.imageView.rx.image)
            .disposed(by: cell.reusableDisposeBag)
        // cell.setUpCell(url: url)
        return cell
    }
}

extension Observable {
    // swiftlint:disable:next syntactic_sugar
    typealias OptionalElement = Optional<Element>
    func asOptional() -> Observable<OptionalElement> {
        return map({ element -> OptionalElement in return element })
    }
}

class MockedDataSource: NSObject, UICollectionViewDataSource {
    var emojiMock: MockEmojis = .init()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiMock.emojis.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as?
                CollectionViewCell else {
            return UICollectionViewCell()
        }
        // cell.setUpCell(url: emojiMock.emojis[indexPath.row].imageUrl)
        return cell
    }
}
