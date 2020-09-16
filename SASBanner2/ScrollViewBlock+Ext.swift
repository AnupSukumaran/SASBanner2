//
//  ScrollViewBlock+Ext.swift
//  SASPager
//
//  Created by Manu Puthoor on 17/02/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit
import WebKit

extension ScrollViewBlock: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        actionAfterScrolling(scrollView, pageControl: pageControl, view: self)
    }
    
    func loadViewFromNib(_ bgColor: UIColor = .white) -> UIView? {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ScrollViewBlock", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.backgroundColor = bgColor
        return view
    }

    func xibSetup(bgColor: UIColor = .white, hidePageControlDots: Bool) {
        
        guard let view = loadViewFromNib(bgColor) else {return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
        addSubview(view)
        contentView = view
        
        pageControl.isHidden = false
        
    }
    
    func settingPageViewController(baseVC: UIViewController) {
       
        let bundle = Bundle(for: type(of: self))
        var pageVC = PageSlideViewController(nibName: "PageSlideViewController", bundle: bundle)
        
        pageVC = PageSlideViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        if let imgs = images {
            pageVC.images = imgs.compactMap{$0}
        }
        pageControl.isHidden = false
        baseVC.view.bringSubviewToFront(pageControl)

        baseVC.addChild(pageVC)
        pageVC.view.frame = bounds
        contentView!.addSubview(pageVC.view)
        
        pageVC.didMove(toParent: baseVC)
        self.pageVC = pageVC
    }
    
    func pageControlSetup() {
        print("images?.count ?? 0 = \(images?.count ?? 0)")
        print("pageControl = \(pageControl.isHidden)")
        pageControl.numberOfPages = images?.count ?? 0
        pageControl.currentPage = 0
       
    }

    func pageControlSetupForViews(views: [UIView]) {
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
        bringSubviewToFront(pageControl)
    }

    func actionAfterScrolling(_ scrollView: UIScrollView, pageControl: UIPageControl, view: UIView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
}

extension ScrollViewBlock:  WKUIDelegate, WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        delegate.startLoading()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delegate.stopLoading()
    }
}
