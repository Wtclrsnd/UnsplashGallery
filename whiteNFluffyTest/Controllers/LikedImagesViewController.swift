//
//  LikedImagesViewController.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 31.01.2022.
//

import UIKit
import Kingfisher


protocol LikedImageViewControllerDelegate: AnyObject {
	func update(photo: Photo)
}

class LikedImagesViewController: UIViewController {
	func passImages(photos: [Photo]) {
		likedPhotos = photos
	}

	private let reusableIdentifier = "myCell"

	lazy var likedPhotos = [Photo]() {
		didSet {
			collectionView.reloadData()
		}
	}

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

		collectionView.allowsSelection = true
		collectionView.isUserInteractionEnabled = true
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.delegate = self
		collectionView.dataSource = self

		collectionView.register(UnsplashCollectionViewCell.self, forCellWithReuseIdentifier: reusableIdentifier)

		return collectionView
	}()

	private func createLayout() -> UICollectionViewLayout {
		let spacing: CGFloat = 27
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(200),
			heightDimension: .absolute(250))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = .init(top: 30, leading: 40, bottom: spacing, trailing: 15)

		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalWidth(0.5))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

		let section = NSCollectionLayoutSection(group: group)
		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(collectionView)
		collectionView.frame = view.bounds
		navigationController?.navigationBar.tintColor = .systemPink
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		likedPhotos = Images.shared.photos.filter { $0.likedByUser ?? false }
	}
}

extension LikedImagesViewController: UICollectionViewDelegate {

}

extension LikedImagesViewController: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return likedPhotos.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! UnsplashCollectionViewCell
		cell.backgroundColor = .clear
		let photoUrlString = likedPhotos[indexPath.row].url
		guard let urlString = photoUrlString else { return cell }
		let photoUrl = URL(string: urlString)
		cell.photoImageView.kf.setImage(with: photoUrl)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let photo = likedPhotos[indexPath.row]
		let vc = DetailPhotoViewController()
		vc.delegate = self
		vc.photo = photo
		navigationController?.pushViewController(vc, animated: true)
	}

}

extension LikedImagesViewController: LikedImageViewControllerDelegate {
	func update(photo: Photo) {
		likedPhotos.append(photo)
	}
}
