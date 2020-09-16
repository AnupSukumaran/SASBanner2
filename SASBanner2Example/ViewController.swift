//
//  ViewController.swift
//  SASBanner2Example
//
//  Created by Manu Puthoor on 16/09/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit
import SASBanner2

class ViewController: UIViewController {

    @IBOutlet weak var bannerView: ScrollViewBlock!
    
    var dummyImgs = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.congifBanner(images: dummyImgs, baseVC: self, imageFit: .scaleAspectFill)
    }

    @IBAction func btnAction() {
        bannerView.stopAutoScroll()
        bannerView.pageVC.forwardPage()
    }
    
    @IBAction func btnAction2() {
        bannerView.startAutoScroll()
        bannerView.pageVC.backwardPage()
    }

}

