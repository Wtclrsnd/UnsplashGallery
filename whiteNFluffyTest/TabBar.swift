//
//  TabBar.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 31.01.2022.
//

import UIKit

class TabBar: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		UITabBar.appearance().barTintColor = .systemBackground
		tabBar.tintColor = .systemPink
		tabBar.isTranslucent = false
		setupVCs()
	}

	private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		navController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title
		return navController
	}

	private func setupVCs() {
		viewControllers = [
			createNavController(for: UnsplashViewController(), title: "Unsplash", image: UIImage(systemName: "photo.circle") ?? UIImage()),
			createNavController(for: LikedImagesViewController(), title: "Liked Images", image: UIImage(systemName: "heart.circle") ?? UIImage())
		]
	}
}
