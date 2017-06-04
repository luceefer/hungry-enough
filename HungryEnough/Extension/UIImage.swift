//
//  UIImage.swift
//  Hungry Enough
//
//  Created by Diep Nguyen Hoang on 6/17/15.
//  Copyright © 2017 Hungry Enough. All rights reserved.
//

import UIKit

extension UIImage {

    convenience init?(named name: String, associatedWith associatedClass: AnyClass) {
        self.init(named: name, in: Bundle(for: associatedClass), compatibleWith: nil)
    }

    static func imageFrom(_ image: UIImage!, withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)

        context?.setBlendMode(.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        context?.draw(image.cgImage!, in: rect)

        context?.setBlendMode(.sourceIn)
        context?.addRect(rect)
        context?.drawPath(using: .fill)

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return result!
    }

    static func image(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

    func scaleToSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }

    func scaleToMaxSize(_ maxSize: CGFloat) -> UIImage {
        let scaleRatio = max(self.size.width, self.size.height) / maxSize
        if scaleRatio < 1 {
            return self
        }
        let newWidth = self.size.width / scaleRatio
        let newHeight = self.size.height / scaleRatio
        return self.scaleToSize(CGSize(width: newWidth, height: newHeight))
    }
}
