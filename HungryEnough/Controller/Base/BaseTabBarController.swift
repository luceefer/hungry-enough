//
//  BaseTabBarController.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 5/31/17.
//  Copyright © 2017 HungryEnough. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor(netHex: 0xF5F0F0)
        self.tabBar.tintColor = .white

        let inactiveColor = UIColor(netHex: 0x4A90E2, alpha: 0.6)
        if let items = self.tabBar.items {
            items.forEach {
                if let image = $0.selectedImage {
                    $0.image = UIImage.imageFrom(image, withColor: AppTheme.MainTheme)
                        .withRenderingMode(.alwaysOriginal)
                }
                $0.setTitleTextAttributes([NSForegroundColorAttributeName: inactiveColor], for: .normal)
                $0.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)
            }
            let numberOfItems = CGFloat(items.count)
            let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
            tabBar.selectionIndicatorImage =
                UIImage.image(inactiveColor, size: tabBarItemSize).resizableImage(withCapInsets: .zero)
        }
        self.tabBar.frame.size.width = self.view.frame.width + 4
        self.tabBar.frame.origin.x = -2
    }
}
