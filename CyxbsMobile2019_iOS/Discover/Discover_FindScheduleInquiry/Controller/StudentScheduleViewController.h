//
//  StudentScheduleViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/20.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol StudentScheduleDelegate <NSObject>

-(void) pushToController:(UIViewController*) studentListVC;

@end
@interface StudentScheduleViewController : UIViewController
@property (nonatomic, weak)id<StudentScheduleDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
