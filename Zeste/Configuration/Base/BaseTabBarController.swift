//
//  BaseTabBarController.swift
//  Zeste
//
//  Created by miori Lee on 2021/10/03.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    let mainViewController  = MainViewController()
    //let networkViewController = NetworkMainViewController()
    
    let actionTabBarItem  = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 0)
   // let networkTabBarItem = UITabBarItem(title: "tabB", image: UIImage(systemName: "network"), tag: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let actionNavigationController = UINavigationController(rootViewController: mainViewController)
       // let networkNavigationController = UINavigationController(rootViewController: networkViewController)
        
        actionNavigationController.tabBarItem  = actionTabBarItem
       // networkNavigationController.tabBarItem = networkTabBarItem
        
        //self.viewControllers = [actionNavigationController, networkNavigationController]
        self.viewControllers = [actionNavigationController]
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
