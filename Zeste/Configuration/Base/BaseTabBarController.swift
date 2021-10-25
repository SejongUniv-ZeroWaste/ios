//
//  BaseTabBarController.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/03.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    let mainViewController  = MainViewController()
    let howToWashVC = HowToWashViewController()
    
    let actionTabBarItem  = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 0)
    let howtoTabBarItem = UITabBarItem(title: "tabB", image: UIImage(systemName: "questionmark.circle.fill"), tag: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let actionNavigationController = UINavigationController(rootViewController: mainViewController)
        let howtoNavigationController = UINavigationController(rootViewController: howToWashVC)
        
        actionNavigationController.tabBarItem  = actionTabBarItem
        howtoNavigationController.tabBarItem = howtoTabBarItem
        
        //self.viewControllers = [actionNavigationController, networkNavigationController]
        self.viewControllers = [actionNavigationController, howtoNavigationController]
        self.delegate = self
        setColor()
    }
}

extension BaseTabBarController {
    private func setColor() {
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .zestGreen
    }
}
