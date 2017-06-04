//
//  UIButton.swift
//  HungryEnough
//
//  Created by Diep Nguyen Hoang on 6/3/17.
//  Copyright © 2017 HungryEnough. All rights reserved.
//

import UIKit

@IBDesignable
class LeftAlignedIconButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right
            - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
    }
}

@IBDesignable
class RightAlignedIconButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left
            - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
    }
}
