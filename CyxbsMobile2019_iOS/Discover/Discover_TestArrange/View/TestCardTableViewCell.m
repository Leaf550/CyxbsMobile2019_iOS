//
//  TestCardTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/1/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "TestCardTableViewCell.h"
#define Color21_49_91_F0F0F2  [UIColor colorNamed:@"color21_49_91&#F0F0F2" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil]
#define color242_243_248toFFFFFF [UIColor colorNamed:@"color242_243_248&#FFFFFF" inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil]

@implementation TestCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = color242_243_248toFFFFFF;
        [self addWeekTimeLabel];
        [self addLeftDayLabel];
        [self addBottomView];
        [self addSubjectLabel];
        [self addClockImage];
        [self addLocationImage];
        [self addTestNatureLabel];
        [self addDayLabel];
        [self addTimeLabel];
        [self addClassLabel];
        [self addSeatNumLabel];
    }
    return self;
}
-(void)addWeekTimeLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"十一周周一";
    label.font = [UIFont fontWithName:PingFangSCBold size:15];
    label.textColor = Color21_49_91_F0F0F2;
    self.weekTimeLabel = label;
    [self.contentView addSubview:label];
}
-(void)addLeftDayLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"还剩5天考试";
    label.font = [UIFont fontWithName:PingFangSCRegular size:13];
    label.textColor = [UIColor colorWithRed:58/255.0 green:57/255.0 blue:211/255.0 alpha:1];
    self.leftDayLabel = label;
    [self.contentView addSubview:label];
}
- (void) addBottomView {
    UIView *backgroundView = [[UIView alloc]init];
    self.bottomView = backgroundView;
    backgroundView.backgroundColor = [UIColor colorWithRed:232/255.0 green:241/255.0 blue:252/255.0 alpha:1.0];
    backgroundView.layer.cornerRadius = 8;
    backgroundView.clipsToBounds = YES;
    [self.contentView addSubview:backgroundView];
}
- (void) addSubjectLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"大学物理";
    label.font = [UIFont fontWithName:PingFangSCBold size:18];
    label.textColor = Color21_49_91_F0F0F2;
    self.subjectLabel = label;
    [self.contentView addSubview:label];
}
- (void) addClockImage {
    UIImageView *clockImageView = [[UIImageView alloc]init];
    self.clockImage = clockImageView;
    [clockImageView setImage:[UIImage imageNamed:@"clockImage"]];
    [self.contentView addSubview:clockImageView];
}
- (void) addLocationImage {
    UIImageView *locationImageView = [[UIImageView alloc]init];
    self.locationImage = locationImageView;
    [locationImageView setImage:[UIImage imageNamed:@"locationImage"]];
    [self.contentView addSubview:locationImageView];
}
- (void) addTestNatureLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"半期";
    label.font = [UIFont fontWithName:PingFangSCRegular size:13];
    label.textColor = Color21_49_91_F0F0F2;
    self.testNatureLabel = label;
    [self.contentView addSubview:label];
}
- (void) addDayLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"11月8号";
    label.font = [UIFont fontWithName:PingFangSCRegular size:13];
    label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:0.59];
    self.dayLabel = label;
    [self.contentView addSubview:label];
}

- (void) addTimeLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"14:00 - 16:00";
    label.font = [UIFont fontWithName:PingFangSCRegular size:13];
    label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:0.59];
    self.timeLabel = label;
    [self.contentView addSubview:label];
}
- (void) addClassLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"3402";
    label.font = [UIFont fontWithName:PingFangSCRegular size:13];
    label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:0.59];
    self.classLabel = label;
    [self.contentView addSubview:label];
}
-(void) addSeatNumLabel {
    UILabel *label = [[UILabel alloc]init];
    label.text = @"58号";
    label.font = [UIFont fontWithName:PingFangSCRegular size:13];
    label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:0.59];
    self.seatNumLabel = label;
    [self.contentView addSubview:label];
}
- (void)layoutSubviews {
    [self.weekTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self);
    }];
    [self.leftDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-11);
        make.centerY.equalTo(self.weekTimeLabel);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@113);
        make.top.equalTo(self.weekTimeLabel.mas_bottom).offset(7);
    }];
    [self.subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(23);
        make.top.equalTo(self.bottomView).offset(15);
    }];
    [self.testNatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subjectLabel);
        make.right.equalTo(self.bottomView).offset(-18);
    }];
    [self.clockImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subjectLabel);
        make.width.height.equalTo(@11);
        make.top.equalTo(self.subjectLabel.mas_bottom).offset(10);
    }];
    [self.locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.clockImage);
        make.top.equalTo(self.clockImage.mas_bottom).offset(16);
    }];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clockImage.mas_right).offset(10);
        make.centerY.equalTo(self.clockImage);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(18);
        make.centerY.equalTo(self.dayLabel);
    }];
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel);
        make.centerY.equalTo(self.locationImage);
    }];
    [self.seatNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classLabel.mas_right).offset(18);
        make.centerY.equalTo(self.classLabel);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
