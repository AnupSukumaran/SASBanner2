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
    
    func loadPageSlideViewController(_ bgColor: UIColor = .white, baseVC: UIViewController)  -> UIView? {

        let bundle = Bundle(for: type(of: self))
        let pageVC = PageSlideViewController(nibName: "PageSlideViewController", bundle: bundle)
        baseVC.addChild(baseVC)
        if let imgs = self.images {
            pageVC.images = imgs.compactMap{$0}
        }

        return pageVC.view
       
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


    
    func setupScrollViewForView(views: [UIView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(views.count), height: frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< views.count {
            views[i].frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
            scrollView.addSubview(views[i])
        }
    }

    

    public func manualScrollingAction() {

        let maxScrollContentWidth = scrollView.contentSize.width
        
        let scrollFrameWidth = scrollView.frame.size.width
        let scrollXAxisContentOffset = scrollView.contentOffset.x
        let viewWidth = frame.width
        
        let changingScrollWidth = (scrollFrameWidth + scrollXAxisContentOffset + viewWidth)

        (maxScrollContentWidth > changingScrollWidth) ?
        (scrollView.setContentOffset(CGPoint(x: scrollXAxisContentOffset + viewWidth, y: 0), animated: true)) :
        (scrollView.setContentOffset(CGPoint(x: (maxScrollContentWidth - scrollFrameWidth), y: 0), animated: true))

    }
    
    public func forceScrollingTo(index: Int) {
        let scrollXAxisContentOffset = scrollView.contentOffset.x
        let viewWidth = frame.width * CGFloat(index)
        (scrollView.setContentOffset(CGPoint(x: scrollXAxisContentOffset + viewWidth , y: 0), animated: true))
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
