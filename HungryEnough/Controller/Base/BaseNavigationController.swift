//
//  BaseNavigationController.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 3/3/17.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.delegate = self
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.topViewController?.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - Navigation Support

extension UIViewController {

    var navigationIdentifier: String {
        return String(describing: type(of: self))
    }
}

extension UINavigationController {

    static func navigate(to vc: UIViewController) {
        if let topVc = UINavigationController.topController() {
            topVc.navigationController?.pushViewController(vc, animated: true)
        }
    }

    static func topController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        if let navigation = topController as? UINavigationController {
            topController = navigation.visibleViewController
        }
        return topController
    }
}
