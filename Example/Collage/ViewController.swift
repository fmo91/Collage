//
//  ViewController.swift
//  Collage
//
//  Created by fmo91 on 02/22/2017.
//  Copyright (c) 2017 fmo91. All rights reserved.
//

import UIKit
import Collage

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var canvas: Collage.Canvas!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = #imageLiteral(resourceName: "mainBackground").size
        
        canvas = Collage.Canvas(size: size)
        
        let mainBackground = Collage.Picture(image: #imageLiteral(resourceName: "mainBackground"))
            .set(color: UIColor.red)
        
        let secondaryBackground = Collage.Picture(image: #imageLiteral(resourceName: "secondaryBackground"))
            .set(color: UIColor.blue)
        
        let parts = Collage.Picture(image: #imageLiteral(resourceName: "parts"))
            .set(color: UIColor.purple)
        
        
        canvas
            .add(mainBackground)
            .add(secondaryBackground)
            .add(parts)
            .paste(on: imageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

