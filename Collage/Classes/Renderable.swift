//
//  Pastable.swift
//  Pods
//
//  Created by Fernando on 22/2/17.
//
//

import Foundation

public protocol Renderable {
    var size: CGSize { get }
    
    func getImage(completionHandler: @escaping (UIImage?) -> Void)
}
