//
//  Picture.swift
//  Pods
//
//  Created by Fernando on 22/2/17.
//
//

import Foundation

public class Picture: Renderable {
    
    private var image: UIImage
    private var rotation: CGFloat?
    private var color: UIColor?
    
    public init(image: UIImage) {
        self.image = image
    }
    
//    @discardableResult
//    public func set(rotation: CGFloat) -> Picture {
//        self.rotation = rotation
//        return self
//    }
    
    @discardableResult
    public func set(color: UIColor) -> Picture {
        self.color = color
        return self
    }
    
    public var size: CGSize {
        return image.size
    }
    
    public func getImage(completionHandler: @escaping (UIImage?) -> Void) {
        UIGraphicsBeginImageContextWithOptions(self.image.size, false, self.image.scale)
        
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            completionHandler(nil)
            return
        }
        
        let pictureBounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        image.draw(in: pictureBounds)
        
        let flipVertical: CGAffineTransform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: -1.0, tx: 0.0, ty: size.height)
        context.concatenate(flipVertical)
        
        
        if let cgImage = image.cgImage {
            context.clip(to: pictureBounds, mask: cgImage)
        }
        
        if let color = color {
            color.setFill()
            context.fill(pictureBounds)
        }
        
        if let rotation = rotation {
            context.rotate(by: rotation)
        }
        
        
        if let resultImage = UIGraphicsGetImageFromCurrentImageContext() {
            self.image = resultImage
        }
        
        UIGraphicsEndImageContext()
        
        completionHandler(self.image)
    }
}
