//
//  Canvas.swift
//  Pods
//
//  Created by Fernando on 22/2/17.
//
//

import Foundation

// Builder class
public class Canvas: Renderable {
    
    private let size: CGSize
    
    public init(size: CGSize) {
        self.size = size
    }
    
    @discardableResult
    public func add(_ pastable: Renderable) -> Canvas {
        return self
    }
    
    public var resultImage: UIImage {
        return UIImage()
    }
    
}
