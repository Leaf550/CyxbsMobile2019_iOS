//
//  BaseTabBar.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/3/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ClassScheduleTabBarView;
@interface ClassTabBar : UITabBar

@property (nonatomic, weak) ClassScheduleTabBarView <updateSchedulTabBarViewProtocol>*classScheduleTabBarView;

@end

NS_ASSUME_NONNULL_END
