//
//  DetailPhotoViewController.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 02.02.2022.
//

import UIKit
import Kingfisher

class DetailPhotoViewController: UIViewController {

	var photo: Photo?

	weak var delegate: LikedImageViewControllerDelegate?

	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private lazy var likeButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "heart"), for: .normal)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		button.tintColor = .systemPink
		return button
	}()

	private lazy var authorLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "text"
		label.font = .boldSystemFont(ofSize: 20)
		label.lineBreakMode = .byWordWrapping
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()

	private lazy var buttonStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.spacing = 15
		return stack
	}()

	private lazy var mainStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 15
		return stack
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		setUpUI()

		guard let urlString = photo?.url else { return }
		let url = URL(string: urlString)
		guard let url = url else { return }
		imageView.load(url: url)
		authorLabel.text = photo?.author
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let liked = photo?.likedByUser else { return }
		if liked {
			likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
		} else {
			likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
		}
	}

	@objc private func buttonTapped() {
		if photo?.likedByUser == false {
			likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
			photo?.likedByUser = true
			delegate?.update(photo: photo ?? Photo())
			guard let idx = Images.shared.photos.firstIndex(where: { $0.url == photo?.url })
			else { return }
			Images.shared.photos[idx].likedByUser = true
		} else {
			likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
			photo?.likedByUser = false
			delegate?.update(photo: photo ?? Photo())
			guard let idx = Images.shared.photos.firstIndex(where: { $0.url == photo?.url })
			else { return }
			Images.shared.photos[idx].likedByUser = false
		}
	}

	private func setUpUI() {
		view.addSubview(mainStack)
		mainStack.addArrangedSubview(imageView)
		mainStack.addArrangedSubview(buttonStack)
		buttonStack.addArrangedSubview(likeButton)
		buttonStack.addArrangedSubview(authorLabel)

		mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
		mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
		mainStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
		mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
	}
}

extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
