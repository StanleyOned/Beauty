//
//  CustomPresentation.swift
//  Beauty
//
//  Created by Stanley Delacruz on 6/3/15.
//  Copyright (c) 2015 Delacruz Inc. All rights reserved.
//

import UIKit

class CustomPresentation:NSObject, UIViewControllerAnimatedTransitioning {
    
    var presenting = false
    var originFrame = CGRect.zero
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let addFriendVC = presenting ? toView  : transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        containerView!.addSubview(toView)
        toView.alpha = 0.0
       // toView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { _ in
            toView.alpha = 1.0
        //    toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: { _ in
                transitionContext.completeTransition(true)
                self.presenting = true
        })
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
}
