//
//  Picture.swift
//  Pods
//
//  Created by Fernando on 22/2/17.
//
//

import Foundation

public class Picture: Renderable {
    
    private let image: UIImage
    
    public init(image: UIImage) {
        self.image = image
    }
    
    @discardableResult
    public func set(rotation: CGFloat) -> Picture {
        return self
    }
    
    @discardableResult
    public func set(size: CGSize) -> Picture {
        return self
    }
    
    @discardableResult
    public func set(color: UIColor) -> Picture {
        return self
    }
    
    public var resultImage: UIImage {
        return image
    }
}
