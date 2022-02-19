//
//  ViewController.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 31.01.2022.
//

import UIKit
import Kingfisher

class UnsplashViewController: UIViewController, LikedImageViewControllerDelegate {

	func update(photo: Photo) {

		guard let idx = photos.firstIndex(where: { $0.url == photo.url })
		else { return }

		photos[idx] = photo
	}

	private let reusableIdentifier = "myCell"

	private lazy var photos = [Photo]() {
		didSet {
			collectionView.reloadData()
		}
	}

	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())

		collectionView.allowsSelection = true
		collectionView.isUserInteractionEnabled = true
		collectionView.delegate = self
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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

		setupUI()
		getPhotos()

		collectionView.reloadData()
	}

	private func setupUI() {
		view.addSubview(collectionView)
		navigationController?.navigationBar.tintColor = .systemPink
	}

	private func getPhotos(){
		let mainURL = "https://api.unsplash.com/photos?client_id="
		let key = "x1rXThIwhUY7c9oK5HK9xQSO_TiW0NDwjQfhLRkrf6U"
		DispatchQueue.main.async {
			guard let url = URL(string: mainURL + key) else { return }
			let request = URLRequest(url: url)

			UnsplashAPI.getRandomPhoto(request: request, completion: { gotPhotos in
				Images.shared.photos = gotPhotos
				self.photos = Images.shared.photos
			})
		}
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
}

extension UnsplashViewController: UICollectionViewDelegate {
}

extension UnsplashViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photos.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! UnsplashCollectionViewCell
		cell.backgroundColor = .clear
		let photoUrlString = photos[indexPath.row].url
		guard let urlString = photoUrlString else { return cell }
		let photoUrl = URL(string: urlString)
		cell.photoImageView.kf.setImage(with: photoUrl)
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let photo = photos[indexPath.row]
		let vc = DetailPhotoViewController()
		vc.delegate = self
		vc.photo = photo
		navigationController?.pushViewController(vc, animated: true)
	}
}
