//
//  WBHomePopoverAnimator.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBHomePopoverAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var presentFrame = CGRectZero
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let pc =  WBCustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
        
        pc.presentFrame = presentFrame
        
        return pc
    }
    
    @objc func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewKey)
        //        let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewKey)
        
        if let view_to = transitionContext.viewForKey(UITransitionContextToViewKey) {
            
            //            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            //                view_to.alpha = 0.0
            //                }, completion: { (finished: Bool) in
            //                    view_to.alpha = 1.0
            //                    transitionContext.containerView()?.addSubview(view_to) // 一定要写
            //                    transitionContext.completeTransition(true) // 一定要写
            //            })
            
            view_to.transform = CGAffineTransformMakeScale(1.0, 0)
            view_to.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            transitionContext.containerView()?.addSubview(view_to)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                view_to.transform = CGAffineTransformIdentity
                }, completion: { (finished: Bool) in
                    transitionContext.completeTransition(true)
            })
            
            NSNotificationCenter.defaultCenter().postNotificationName(WBPopoverAnimatorWillShow, object: nil)
            
        }
        
        if let view_from = transitionContext.viewForKey(UITransitionContextFromViewKey) {
            
            //            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            //                view_from.alpha = 1.0
            //                }, completion: { (finished: Bool) in
            //                    view_from.alpha = 0.0
            //                    view_from.removeFromSuperview() // 一定要写
            //                    transitionContext.completeTransition(true) // 一定要写
            //            })
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                view_from.transform = CGAffineTransformMakeScale(1.0, 0.01)
                }, completion: { (finished: Bool) in
                    transitionContext.completeTransition(true)
            })
            
            NSNotificationCenter.defaultCenter().postNotificationName(WBPopoverAnimatorWillDismiss, object: nil)
            
        }
        
    }

}
