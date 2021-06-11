//
//  ViewController.swift
//  Create-image-from-array
//
//  Created by Ran Helfer on 08/06/2021.
//

import UIKit
import Foundation


class ViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    let imageFromArrayCalc = UIImageFromArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 1

        widthConstraint.constant = 300
        heightConstraint.constant = 300
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.image = imageFromArrayCalc.getImageFromGrayScale()

    }
}

