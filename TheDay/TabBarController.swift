//
//  MainViewController.swift
//  TheDay
//
//  Created by 이석원 on 2022/09/30.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        feedViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        
        let starViewController = StarViewController()
        starViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo.fill"))
        
        
        let settingViewController = SettingViewController()
        settingViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        viewControllers = [feedViewController, starViewController, settingViewController]

    }

}

