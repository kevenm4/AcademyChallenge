//
//  AvatarViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit
class AvatarViewController: BaseGenericViewController<AvatarView> {
    weak var delegate: BackToFirstViewControllerDelegate?
    var avatarList: [Avatar] = []
    var viewModel: AvatarListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        genericView.collectionView.dataSource = self
        genericView.collectionView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.getAvatar()
            .subscribe(onSuccess: { avatar in
                self.avatarList = avatar
                self.genericView.collectionView.reloadData()
            }, onFailure: { error in
                print("[GetEmojisList-ViewModel] \(error)")
            },
                       onDisposed: {
                print("GOOOOOOO")
            })
            .disposed(by: disposeBag)
    }
    deinit {
        self.delegate?.navigateBackToFirstPage()
    }

    private func deleteAlert(indexPath: IndexPath) {
        let alert = genericView.createDeleteAlert { [weak self] in
            guard let self = self else { return }
            let avatar = self.avatarList[indexPath.row]
            self.viewModel?.delete(avatar: avatar )
                .subscribe {  completable in
                    switch completable {
                    case.completed:
                        print("Avatar deleted")
                        self.genericView.collectionView.reloadData()
                    case.error(let error):
                        print("Completed with an error: \(error.localizedDescription)")
                    }
                }
                .disposed(by: self.disposeBag)
            self.avatarList.remove(at: indexPath.row)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension AvatarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let countAvatar = avatarList.count
        return countAvatar
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let url = avatarList[indexPath.row].avatarUrl
        cell.setUpCells(url: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deleteAlert(indexPath: indexPath)
    }

}

extension AvatarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    func collectionView (_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard  let layout = collectionViewLayout as? UICollectionViewFlowLayout else {return .zero}
        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
}
