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
         bannerView.baseVC = self
         bannerView.images = dummyImgs
         bannerView.imgFit = .scaleAspectFit
    }

    @IBAction func btnAction() {
        
    }

}

