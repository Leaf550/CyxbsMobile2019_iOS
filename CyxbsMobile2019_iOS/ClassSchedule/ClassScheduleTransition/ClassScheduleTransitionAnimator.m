//
//  ClassScheduleTransitionAnimator.m
//  CyxbsMobile2019_iOS
//
//  Created by wmt on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ClassScheduleTransitionAnimator.h"
#import "ClassTabBarController.h"
#import "WYCClassBookViewController.h"

@implementation ClassScheduleTransitionAnimator


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if ([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isMemberOfClass:[ClassTabBarController class]]) {
        WYCClassBookViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ClassTabBarController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        if (IS_IPHONEX) {
                   to.view.frame = CGRectMake(0, MAIN_SCREEN_H - 104 - 50 + 16, MAIN_SCREEN_W, MAIN_SCREEN_H);
               } else {
                   to.view.frame = CGRectMake(0, MAIN_SCREEN_H - 89 - 30 + 16, MAIN_SCREEN_W, MAIN_SCREEN_H);
               }
               [transitionContext.containerView addSubview:to.view];
       [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
                  to.view.frame = CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H);
                  if (@available(iOS 11.0, *)) {
                      to.view.backgroundColor = [UIColor colorNamed:@"Mine_Store_BackgroundColor"];
                  } else {
                      to.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1.0];
                  }
                  from.view.layer.affineTransform = CGAffineTransformMakeScale(0.88, 0.88);
                  from.view.layer.cornerRadius = 16;
                  from.view.clipsToBounds = YES;
              } completion:^(BOOL finished) {
                  BOOL wasCanceled = [transitionContext transitionWasCancelled];
                  if (wasCanceled) {
                      [to.view removeFromSuperview];
                  }
                  [transitionContext completeTransition:!wasCanceled];
              }];
              } else {
                  ClassTabBarController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

                 WYCClassBookViewController*from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
                  
                  [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
                      if (IS_IPHONEX) {
                          from.view.frame = CGRectMake(0, MAIN_SCREEN_H - 104 - 50 + 16, MAIN_SCREEN_W, MAIN_SCREEN_H);
                      } else {
                          from.view.frame = CGRectMake(0, MAIN_SCREEN_H - 89 - 30 + 16, MAIN_SCREEN_W, MAIN_SCREEN_H);
                      }
                    
                          from.view.backgroundColor = [UIColor whiteColor];
                      from.view.backgroundColor = from.view.backgroundColor;
                      to.view.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
                      to.view.layer.cornerRadius = 0;
                  } completion:^(BOOL finished) {
                      BOOL wasCanceled = [transitionContext transitionWasCancelled];
                      if (!wasCanceled) {
                          [from.view removeFromSuperview];
                      }
                      [transitionContext completeTransition:!wasCanceled];
                  }];
              }
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

@end
