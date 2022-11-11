//
//  AvatarViewController.swift
//  AcademyChallenge
//
//  Created by Keven Esmael on 26/09/2022.
//

import UIKit

public protocol AvatarViewControlerDelegate: AnyObject {
    func navigateToFirstPage()
}

class AvatarViewController: BaseGenericViewController<AvatarView> {
    public weak var delegate: AvatarViewControlerDelegate?
    var avatarList: [Avatar] = []
    var viewModel: AvatarListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        genericView.collectionView.dataSource = self
        genericView.collectionView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.arrAvatar.bind(listener: { [weak self] newArrAvatar in
            self?.avatarList = newArrAvatar!
            self?.genericView.collectionView.reloadData()
        })
        viewModel?.getAvatar()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.navigateToFirstPage()
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
        let alert = UIAlertController(title: "Delete Avatar",
                                      message: "Are you sure you want delete ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(_: UIAlertAction!) in
            let avatar = self.avatarList[indexPath.row]
            self.viewModel?.deleteAV(avatar: avatar)
            self.avatarList.remove(at: indexPath.row)
            collectionView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
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
