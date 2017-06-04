//
//  Tool.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 6/13/15.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import UIKit
import SwiftMessages

struct Tool {

    // MARK: - Alerts

    static func showError(_ message: String) {
        if let topMostController = UINavigationController.topController() {
            Tool.showMessage(topMostController,
                             title: NSLocalizedString("general.title.error", comment: ""),
                             message: message)
        }
    }

    static func showMessage(_ title: String, message: String) {
        if let topMostController = UINavigationController.topController() {
            Tool.showMessage(topMostController, title: title, message: message)
        }
    }

    static func showMessage(_ caller: UIViewController, title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.addAction(
            UIAlertAction(title: NSLocalizedString("general.button.ok", comment: ""), style: .default, handler: nil))
        caller.present(vc, animated: true, completion: nil)
    }

    // MARK: - Notifications

    static func showNotification(
        color: UIColor? = AppTheme.StatusSuccess, content: String, tapHandler: (() -> Void)? = nil) {
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)

        let view = MessageView.viewFromNib(layout: .MessageView)
        view.configureContent(body: content)
        view.button?.isHidden = true
        view.iconImageView?.isHidden = true
        view.iconLabel?.isHidden = true
        view.titleLabel?.isHidden = true
        view.backgroundColor = color
        view.bodyLabel?.textColor = .white

        view.tapHandler = { _ in
            SwiftMessages.hide()
            tapHandler?()
        }
        SwiftMessages.show(config: config, view: view)
    }
}
