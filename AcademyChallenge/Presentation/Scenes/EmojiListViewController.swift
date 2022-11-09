//
//  EmojiListViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit
//
import RxSwift

class EmojiListViewController: BaseGenericViewController<EmojiView> {

    var emoji: [Emoji]?
    var viewModel: EmojiListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        genericView.collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel?.arrEmojis.bind(listener: { [weak self] newArr in

            self?.emoji = newArr

            DispatchQueue.main.async { [weak self] in
                self?.genericView.collectionView.reloadData()
            }

        })

        viewModel?.getEmojis()
    }
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let emojis = self.emoji?[indexPath.row]
        viewModel?.deleteEM(emojis: emojis!)
        self.emoji?.remove(at: indexPath.row)
        collectionView.reloadData()
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
