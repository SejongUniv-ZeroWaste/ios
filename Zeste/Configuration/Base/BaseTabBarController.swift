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
    let newsVC  = NewsViewController()
    let mainViewController2  = MainViewController()
    
    let homtTabBarItem  = UITabBarItem(title: "", image: UIImage(named: "tab1"), tag: 0)
    let locTabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab2"), tag: 1)
    let newsTabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab3"), tag: 2)
    let howTabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab4"), tag: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homNavigationController = UINavigationController(rootViewController: mainViewController)
        let locNavigationController = UINavigationController(rootViewController: mainViewController2)
        let newsNavigationController = UINavigationController(rootViewController: newsVC)
        let howtoNavigationController = howToWashVC
        //UINavigationController(rootViewController: howToWashVC)
        
        homNavigationController.tabBarItem  = homtTabBarItem
        locNavigationController.tabBarItem = locTabBarItem
        newsNavigationController.tabBarItem = newsTabBarItem
        howtoNavigationController.tabBarItem = howTabBarItem
        
        //self.viewControllers = [actionNavigationController, networkNavigationController]
        self.viewControllers = [homNavigationController, locNavigationController, newsNavigationController, howtoNavigationController]
        self.delegate = self
        setColor()
    }
}

extension BaseTabBarController {
    private func setColor() {
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .zestGreen
        
        tabBar.isTranslucent = false
        
        if #available(iOS 15.0, *) {
            
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()
            
            tabBarAppearance.backgroundColor = .zestGreen
            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}
