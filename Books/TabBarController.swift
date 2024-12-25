//
//  TabBarController.swift
//  Books
//
//  Created by Edgar Adamyan on 23.12.24.
//

import UIKit

class TabBarController: UITabBarController {
  
  let homeViewController = UINavigationController(rootViewController: HomeViewController(nibName: "HomeViewController", bundle: nil))

    override func viewDidLoad() {
        super.viewDidLoad()
   
      homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
      
      setViewControllers([homeViewController], animated: true)
      tabBar.tintColor = UIColor(named: "customViolet")
      

    }



}
