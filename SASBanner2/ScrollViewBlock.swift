//
//  ScrollViewBlock.swift
//  SASPager
//
//  Created by Manu Puthoor on 17/02/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit

@objc public protocol ScrollViewBlockDelegate: class {
    func bannerTapAction(index: Int)
    func startLoading()
    func stopLoading()
       
}

public class ScrollViewBlock: UIView {
  
    @IBOutlet public weak var pageControl: UIPageControl!
    @IBOutlet public weak var delegate: ScrollViewBlockDelegate!

    public var pageVC: PageSlideViewController!
    public var baseVC: UIViewController!
    public var viewBGColor: UIColor = .green
    public var hidePageControlDots: Bool = false {
        didSet {
             //xibSetup(bgColor: viewBGColor, hidePageControlDots: hidePageControlDots)
        }
    }
    
    public var imgFit: UIView.ContentMode = .scaleAspectFit
    
  
    
    public var images: [UIImage?]? {
        didSet {
           // xibSetup(bgColor: viewBGColor, hidePageControlDots: hidePageControlDots)
            settingPageViewController(baseVC: baseVC)
           // settingView(imgFit: imgFit)
        }
    }
    
   
    public var contentView: UIView?
    
    
    public var webViewBGC: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    public var contentViewBGC: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
   
    
    public var urlStrings: [String]? {
        didSet {
         //  settingWebViews(webViewBGC: webViewBGC, contentViewBGC: contentViewBGC)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup(bgColor: viewBGColor, hidePageControlDots: hidePageControlDots)
    }
    
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup(bgColor: viewBGColor, hidePageControlDots: hidePageControlDots)
    }
    
    
    override public func layoutSubviews() {
        
        if let imgs = images, !imgs.isEmpty {
            //settingView(imgFit: imgFit)
        }
        
        if let urlStrs = urlStrings, !urlStrs.isEmpty {
           // settingWebViews(webViewBGC: webViewBGC, contentViewBGC: contentViewBGC)
        }
       
    }
    
    @IBAction func manualScrollView(_ sender: UIButton) {
      //  manualScrollingAction()
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.bannerTapAction(index: pageControl.currentPage)
    }
    
}

 
