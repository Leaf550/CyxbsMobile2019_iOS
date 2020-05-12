//
//  BaseTabBarController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/3/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ClassTabBarController.h"
#import "ClassTabBar.h"
#import "ClassSchedulePrecentDrivenViewController.h"
#import "ClassScheduleTransitionAnimator.h"
#import "WYCClassBookViewController.h"
@interface ClassTabBarController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ClassTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValue:[[ClassTabBar alloc] init] forKey:@"tabBar"];
    
    [self addObserver:self forKeyPath:@"tabBar.hidden" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"tabBar.hidden" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([change[NSKeyValueChangeNewKey] boolValue] == YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"classTabBarHasHidden" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"classTabBarHasDisplayed" object:nil];
    }
}
- (void)presentClassBookView:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.presentPanGesture = pan;
        
      WYCClassBookViewController *vc = [[WYCClassBookViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
}
#pragma mark - 转场动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[ClassScheduleTransitionAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[ClassScheduleTransitionAnimator alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (self.presentPanGesture) {
        return [[ClassSchedulePrecentDrivenViewController alloc] initWithPanGesture:self.presentPanGesture];
    } else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (self.presentPanGesture) {
        return [[ClassSchedulePrecentDrivenViewController alloc] initWithPanGesture:self.presentPanGesture];
    } else {
        return nil;
    }
}

@end
