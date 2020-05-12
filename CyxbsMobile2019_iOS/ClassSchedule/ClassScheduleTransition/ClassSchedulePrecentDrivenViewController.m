//
//  ClassSchedulePrecentDrivenViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by wmt on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ClassSchedulePrecentDrivenViewController.h"
#import "ClassTabBarController.h"

@interface ClassSchedulePrecentDrivenViewController ()
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) float lastTranslationY;
@end

@implementation ClassSchedulePrecentDrivenViewController

- (instancetype)initWithPanGesture:(UIPanGestureRecognizer *)panGesture {
    if (self = [super init]) {
        self.panGesture = panGesture;
        [self.panGesture addTarget:self action:@selector(updateAnimation:)];
    }
    return self;
}
-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (void)updateAnimation:(UIPanGestureRecognizer *)sender {
    CGFloat percent = [self gesturePercent:sender];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            break;
            
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:percent / 4];
            
            break;
            
        case UIGestureRecognizerStateEnded:
            if (percent > 0.1) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
        
        default:
            [self cancelInteractiveTransition];
            break;
    }
}
- (CGFloat)gesturePercent:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.transitionContext.containerView];
    
//    _lastTranslationY = translation.y;
    
    // 如果是下拉
    if ([[self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isMemberOfClass:[ClassTabBarController class]]) {
        CGFloat percent = translation.y / MAIN_SCREEN_H;
        if (percent > 0) {
            return percent;
        } else {
            return 0;
        }
    } else {
        return - translation.y / MAIN_SCREEN_H;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
