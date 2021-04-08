//
//  GroupBtn.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/12/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupBtn : UIButton

@property (nonatomic, strong) UIImageView *groupBtnImageView;

@property (nonatomic, strong) UILabel *groupBtnLabel;

///右上角的数字小圆点（目前的思路是UILabel）
@property (nonatomic, strong) UILabel *messageCountLabel;

@end

NS_ASSUME_NONNULL_END
