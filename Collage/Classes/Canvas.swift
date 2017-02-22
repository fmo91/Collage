//
//  Canvas.swift
//  Pods
//
//  Created by Fernando on 22/2/17.
//
//

import Foundation
import UIKit

private typealias Pastable = (renderable: Renderable, position: CGRect)
private typealias CanvasRenderable = (image: UIImage, position: CGRect)

public class Canvas: Renderable {
    
    public let size: CGSize
    
    private let backgroundQueue = DispatchQueue(
        label: "com.fmo91.canvas",
        qos: DispatchQoS.userInteractive
    )
    private let conversionQueue = DispatchQueue(
        label: "com.fmo91.conversion",
        qos: DispatchQoS.userInteractive
    )
    
    private let mainQueue = DispatchQueue.main
    
    private var pastables = [Pastable]()
    
    public init(size: CGSize) {
        self.size = size
        
    }
    @discardableResult
    public func add(_ renderable: Renderable, on frame: CGRect) -> Canvas {
        
        let pastable: Pastable = (
            renderable	: renderable,
            position    : frame
        )
        
        self.pastables.append(pastable)
        
        return self
    }
    
    @discardableResult
    public func add(_ renderable: Renderable, from origin: CGPoint = CGPoint.zero) -> Canvas {
        
        let pastable: Pastable = (
            renderable	: renderable,
            position    : CGRect(x: origin.x, y: origin.y, width: renderable.size.width, height: renderable.size.height)
        )
        
        self.pastables.append(pastable)
        
        return self
    }
    
    public var resultImage: UIImage? {
        
        var canvasRenderables: [CanvasRenderable] = [CanvasRenderable]()
        let group = DispatchGroup()
        
        
        for pastable in pastables {
            group.enter()
            conversionQueue.sync {
                pastable.renderable.getImage(completionHandler: { (image: UIImage?) in
                    if let image = image {
                        let canvasRenderable = (image: image, position: pastable.position)
                        canvasRenderables.append(canvasRenderable)
                    }
                    
                    group.leave()
                })
            }
        }
        
        group.wait(timeout: DispatchTime.distantFuture)
        
        UIGraphicsBeginImageContext(size)
        
        for canvasRenderable in canvasRenderables {
            canvasRenderable.image.draw(in: canvasRenderable.position)
        }
        
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func getImage(completionHandler: @escaping (UIImage?) -> Void) {
        backgroundQueue.async { [weak self] in
            let image = self?.resultImage
            
            self?.mainQueue.async {
                completionHandler(image)
            }
        }
    }
    
    public func paste(on imageView: UIImageView) {
        getImage { (image: UIImage?) in
            imageView.image = image
        }
    }
}
