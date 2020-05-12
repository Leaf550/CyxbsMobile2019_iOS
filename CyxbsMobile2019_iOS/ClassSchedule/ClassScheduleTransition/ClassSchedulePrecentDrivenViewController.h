//
//  ClassSchedulePrecentDrivenViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by wmt on 2020/5/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassSchedulePrecentDrivenViewController : UIPercentDrivenInteractiveTransition

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
- (instancetype)initWithPanGesture:(UIPanGestureRecognizer *)panGesture;
@end

NS_ASSUME_NONNULL_END
