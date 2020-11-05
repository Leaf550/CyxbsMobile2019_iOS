//
//  SetQuestionView.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "SetQuestionView.h"
#import <Masonry.h>

@interface SetQuestionView()

@property (nonatomic, strong) UILabel *barTitle;
@property (nonatomic, strong) UILabel *questionLab;
@property (nonatomic, strong) UILabel *question;
@property (nonatomic, strong) UILabel *answerLab;
@property (nonatomic, strong) UIView *line;

@end

@implementation SetQuestionView

- (instancetype) initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        ///返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"轮播右箭头"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        _backBtn = backBtn;
        
        ///标题
        UILabel *barTitle = [self creatLabelWithText:@"重设密保" AndFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 21] AndTextColor:[UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0]];
        barTitle.textAlignment = NSTextAlignmentLeft;
        barTitle.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0];
        [self addSubview:barTitle];
        _barTitle = barTitle;
        
        ///分割线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1.0];
        [self addSubview:line];
        _line = line;
        
        ///密保问题描述
        UILabel *questionLab = [self creatLabelWithText:@"你的密保问题是:" AndFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 15] AndTextColor:[UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0]];
        questionLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:questionLab];
        _questionLab = questionLab;
        
        ///密保问题
        UILabel *questionLabel = [[UILabel alloc] init];
        questionLabel.userInteractionEnabled = YES;
        questionLabel.layer.borderColor = [[UIColor clearColor] CGColor];
        questionLabel.layer.borderWidth = 1.0;
        questionLabel.layer.masksToBounds = YES;
        questionLabel.layer.cornerRadius = 8;
        [questionLabel setBackgroundColor:[UIColor colorWithRed:232/255.0 green:240/255.0 blue:252/255.0 alpha:1.0]];
        questionLabel.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0];
        questionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:questionLabel];
        _questionLabel = questionLabel;

        
        ///密保答案描述
        UILabel *answerLab = [self creatLabelWithText:@"你的密保答案是:" AndFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 15] AndTextColor:[UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0]];
        questionLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:answerLab];
        _answerLab = answerLab;
    
        ///答案输入框
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
        textView.dataDetectorTypes = UIDataDetectorTypeAll;
        textView.placeholder = @" 请输入密保问题的答案（由2-16位字符组成）";
        textView.layer.cornerRadius = 8;
        textView.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0];
        textView.backgroundColor = [UIColor colorWithRed:232/255.0 green:240/255.0 blue:252/255.0 alpha:1.0];
        [self addSubview:textView];
        _textView = textView;
        
        ///提示文字（少）
        UILabel *placeholderLabLess = [self creatLabelWithText:@"请至少输入两个字符" AndFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] AndTextColor:[UIColor colorWithRed:11/255.0 green:204/255.0 blue:240/255.0 alpha:1.0]];
        [self addSubview:placeholderLabLess];
        _placeholderLabLess = placeholderLabLess;
        
        ///提示文字（多）
        UILabel *placeholderLabMore = [self creatLabelWithText:@"字数不能超过16个" AndFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] AndTextColor:[UIColor colorWithRed:11/255.0 green:204/255.0 blue:240/255.0 alpha:1.0]];
        [self addSubview:placeholderLabMore];
        _placeholderLabMore = placeholderLabMore;
        
        ///确定按钮
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitle:@"确定" forState:UIControlStateDisabled];
        sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        sureBtn.backgroundColor = [UIColor colorWithRed:194/255.0 green:203/255.0 blue:254/255.0 alpha:1.0];
        [sureBtn addTarget:self action:@selector(ClickedSureBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        _sureBtn = sureBtn;
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).mas_offset(SCREEN_HEIGHT * 0.0764);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.0427);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.0187);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0172);
    }];
    
    [_barTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).mas_offset(SCREEN_HEIGHT * 0.0653);
        make.left.mas_equalTo(_backBtn.mas_right).mas_offset(SCREEN_WIDTH * 0.0347);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0357);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).mas_offset(SCREEN_HEIGHT * 0.1071);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(3);
    }];
    
    [_questionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0246);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.0533);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.32 * 21/120);
    }];
    
    [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_questionLab.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0074);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.0427);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.9147);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.9147 * 41/343);
    }];
    
    [_answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1453);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.0533);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.32 * 21/120);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.186);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.0533);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.904);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.904 * 100/339);
    }];
    
    [_placeholderLabLess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textView.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0148);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.056);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.3013 * 17/113);
    }];
    
    [_placeholderLabMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.mas_equalTo(_placeholderLabLess);
    }];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.3941);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.128);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.7467);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.7467 * 52/280);
    }];
    _sureBtn.layer.cornerRadius = _sureBtn.frame.size.height * 1/2;
    
}

///创建提示文字
- (UILabel *)creatLabelWithText:(NSString *)text AndFont:(UIFont *)font AndTextColor:(UIColor *)color {
    UILabel *lab = [[UILabel alloc] init];
    lab.font = font;
    lab.text = text;
    lab.textColor = color;
    return lab;
}


#pragma mark - 代理方法
- (void)backButtonClicked {
    if ([self.delegate respondsToSelector:@selector(backButtonClicked)]) {
        [self.delegate backButtonClicked];
    }
}

- (void)ClickedSureBtn {
    if ([self.delegate respondsToSelector:@selector(ClickedSureBtn)]) {
        [self.delegate ClickedSureBtn];
    }
}


@end
