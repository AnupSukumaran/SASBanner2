//
//  PageSlideViewController.swift
//  Pods-SASBanner_Example
//
//  Created by Manu Puthoor on 15/09/20.
//

import UIKit

public class PageSlideViewController: UIPageViewController {

   var images = [UIImage]()
   //public var testLabels = [String]()
   var currentIndex = 0
   var itemIndex = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let startingViewController = contentViewController(at: itemIndex) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func contentViewController(at index: Int) -> ImageViewController? {
        
        if index < 0 || index >= images.count {
            
            let bundle = Bundle(for: type(of: self))
            let vc = ImageViewController(nibName: "ImageViewController", bundle: bundle)
            guard !images.isEmpty else {return nil}
            vc.imageData = images[0]
            vc.index = 0
            return vc
        }
        
        let bundle = Bundle(for: type(of: self))
        let vc = ImageViewController(nibName: "ImageViewController", bundle: bundle)
        vc.imageData = images[index]
        vc.index = index
        return vc
    }
    
    public func forwardPage() {
        print("currentIndex = \(currentIndex)")
        print("images.count - 1 = \(images.count - 1)")
        guard  currentIndex < (images.count - 1) else {
            currentIndex = 0
            if let nextViewController = contentViewController(at: 0) {
                setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            }
            return
        }
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    public func backwardPage() {
        guard  currentIndex > 0 else {
            currentIndex = images.count - 1
            if let nextViewController = contentViewController(at: currentIndex) {
               setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
            }
            return
        }
        currentIndex -= 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .reverse, animated: true, completion: nil)
        }
    }

    
}


extension PageSlideViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ImageViewController).index
        if index > 0 {
            index -= 1
            return contentViewController(at: index)
        } else {
            return contentViewController(at: images.count - 1)
        }
    
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ImageViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? ImageViewController {
                currentIndex = contentViewController.index
               // pagesDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
        
    }
    
    
}
