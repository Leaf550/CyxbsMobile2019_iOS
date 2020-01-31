//
//  QAAskNextStepView.h
//  CyxbsMobile2019_iOS
//
//  Created by 王一成 on 2020/1/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QAAskNextStepView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
-(void)setupView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *timePickerVIew;
@property (weak, nonatomic) IBOutlet UIView *integralPickView;
@property (weak, nonatomic) IBOutlet UILabel *integralNumLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property(strong,nonatomic)NSMutableArray *timePickViewContent;
@property(copy,nonatomic)NSString *day;
@property(copy,nonatomic)NSString *hour;
@property(copy,nonatomic)NSString *minutes;
@end

NS_ASSUME_NONNULL_END
