//
//  ImageViewController.swift
//  Pods-SASBanner_Example
//
//  Created by Manu Puthoor on 15/09/20.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
   
    var imageData = UIImage()
    var imageContentFit: UIImageView.ContentMode = .scaleAspectFit
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = imageData
        imgView.contentMode = imageContentFit
    }

}
