//
//  TabBar.swift
//  whiteNFluffyTest
//
//  Created by Emil Shpeklord on 31.01.2022.
//

import UIKit

class TabBar: UITabBarController {
    
//    lazy var likedImages = [Photo]()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .systemPink
        tabBar.isTranslucent = false
        setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: UnsplashViewController(), title: "Unsplash", image: UIImage(systemName: "photo.circle")!),
            createNavController(for: LikedImagesViewController(), title: "Liked Images", image: UIImage(systemName: "heart.circle")!)
        ]
    }
}
