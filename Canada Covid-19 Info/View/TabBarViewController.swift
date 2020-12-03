//
//  TabBarViewController.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-17.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusVC = UINavigationController(rootViewController: StatisticViewController())
        let newsVC = UINavigationController(rootViewController: NewsViewController())
        viewControllers = [statusVC, newsVC]
        statusVC.title = "Statistics"
        newsVC.title = "News"
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 11) as Any], for: .normal)

//        statusVC.title = UIFont.systemFont(ofSize: 16.0)
//        newsVC.title = UIFont.systemFont(ofSize: 16.0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
