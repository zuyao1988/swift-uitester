//
//  OnboardingVC.swift
//  UiTester
//
//  Created by Tzuu Yao Lee on 20/9/20.
//  Copyright © 2020 Tzuu Yao Lee. All rights reserved.
//

import UIKit

class OnboardingVC: UIPageViewController {

    lazy var orderedViewControllers: [UIViewController] = {
        return [newVC(withID: VCID_ONBOARD_1),
                newVC(withID: VCID_ONBOARD_2),
                newVC(withID: VCID_ONBOARD_3)]
    }()
    
    var pageControl = UIPageControl()
    
    // Track the current index
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = VIEW_ID_ONBOARD_VIEW
        dataSource = self
        delegate = self
        
        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)            
        }
        
        configurePageControl()
    }
    
    func newVC(withID id: String)-> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    func configurePageControl () {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxX - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
    }
}

extension OnboardingVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let vcIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil}
        
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
//            return nil //no loop
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil}
        
        let nextIndex = vcIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return orderedViewControllers.first
//            return nil
        }
        
//        guard nextIndex >= 0 else {
//            return orderedViewControllers.first
//        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = orderedViewControllers.firstIndex(of: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
         if completed {
           currentIndex = pendingIndex
           if let index = currentIndex {
               pageControl.currentPage = index
           }
       }
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return orderedViewControllers.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
//            return 0
//        }
//
//        return firstViewControllerIndex
//    }
}
