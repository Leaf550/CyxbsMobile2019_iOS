//
//  ResetPwdView.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ResetPwdView.h"
#import <Masonry.h>

@interface ResetPwdView()

@property (nonatomic, strong) UILabel *barTitle;
@property (nonatomic, strong) UIView *passWordLine1;
@property (nonatomic, strong) UIView *passWordLine2;
@property (nonatomic, strong) UIImageView *passwordImageView1;
@property (nonatomic, strong) UIImageView *passwordImageView2;
@property (nonatomic, strong) UIImageView *passwordRightImageView1;
@property (nonatomic, strong) UIButton *passwordRight2;

@end

@implementation ResetPwdView

- (instancetype) initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"我的返回"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        _backBtn = backBtn;
        
        ///bar标题
        if (@available(iOS 11.0, *)) {
            UILabel *barTitle = [self creatLabelWithText:@"重设密码" AndFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 21] AndTextColor:[UIColor colorNamed:@"MGDSafeTextColor"]];
            barTitle.textAlignment = NSTextAlignmentLeft;
            [self addSubview:barTitle];
            _barTitle = barTitle;
        } else {
            // Fallback on earlier versions
        }
        
        ///密码输入框
        UITextField *passwordField1=[self createTextFieldWithFont:[UIFont fontWithName:PingFangSCBold size:18] placeholder:@"请输入6位以上新密码"];
        passwordField1.clearButtonMode = UITextFieldViewModeNever;
        [self addSubview:passwordField1];
        _passwordField1 = passwordField1;
        
        ///密码确认框
        UITextField *passwordField2=[self createTextFieldWithFont:[UIFont fontWithName:PingFangSCBold size:18] placeholder:@"请再次输入6位以上新密码"];
        passwordField2.clearButtonMode = UITextFieldViewModeNever;
        passwordField2.secureTextEntry = YES;
        [self addSubview:passwordField2];
        _passwordField2 = passwordField2;
        
        ///密码提示语（少）
        UILabel *placeholder1Error = [self creatLabelWithText:@"新密码不符合要求，请重新输入" AndFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] AndTextColor:[UIColor colorWithRed:11/255.0 green:204/255.0 blue:240/255.0 alpha:1.0]];
        placeholder1Error.textAlignment = NSTextAlignmentLeft;
        [self addSubview:placeholder1Error];
        _placeholder1Error = placeholder1Error;
        
        ///密码提示语（空）
        UILabel *placeholder1Empty = [self creatLabelWithText:@"新密码不能为空" AndFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] AndTextColor:[UIColor colorWithRed:11/255.0 green:204/255.0 blue:240/255.0 alpha:1.0]];
        placeholder1Empty.textAlignment = NSTextAlignmentLeft;
        [self addSubview:placeholder1Empty];
        _placeholder1Empty = placeholder1Empty;
        
        ///确认密码提示语（少）
        UILabel *placeholder2Error = [self creatLabelWithText:@"确认密码和新密码不符，请重新输入" AndFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] AndTextColor:[UIColor colorWithRed:11/255.0 green:204/255.0 blue:240/255.0 alpha:1.0]];
        placeholder2Error.textAlignment = NSTextAlignmentLeft;
        [self addSubview:placeholder2Error];
        _placeholder2Error = placeholder2Error;
        
        ///确认密码提示语（空）
        UILabel *placeholder2Empty = [self creatLabelWithText:@"确认新密码不能为空" AndFont:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] AndTextColor:[UIColor colorWithRed:11/255.0 green:204/255.0 blue:240/255.0 alpha:1.0]];
        placeholder1Empty.textAlignment = NSTextAlignmentLeft;
        [self addSubview:placeholder2Empty];
        _placeholder2Empty = placeholder2Empty;
        
        
        ///密码下划线
        UIView *passWordLine1 = [[UIView alloc] init];
        passWordLine1.backgroundColor = [UIColor grayColor];
        passWordLine1.alpha = 0.2;
        [self addSubview:passWordLine1];
        _passWordLine1 = passWordLine1;
        
        ///密码确认下划线
        UIView *passWordLine2 = [[UIView alloc] init];
        passWordLine2.backgroundColor = [UIColor grayColor];
        passWordLine2.alpha = 0.2;
        [self addSubview:passWordLine2];
        _passWordLine2 = passWordLine2;
        
        ///密码图片
        UIImageView *passwordImageView1 = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"志愿账号"];
        passwordImageView1.image = image;
        [self addSubview:passwordImageView1];
        _passwordImageView1 = passwordImageView1;
        
        ///密码确认图片
        UIImageView *passwordImageView2 = [[UIImageView alloc] init];
        passwordImageView2.image = image;
        [self addSubview:passwordImageView2];
        _passwordImageView2 = passwordImageView2;
        
        ///下一步按钮
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setTitle:@"下一步" forState:UIControlStateDisabled];
        nextBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 18];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        nextBtn.backgroundColor = [UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1.0];
        [nextBtn addTarget:self action:@selector(ClickedNext) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextBtn];
        _nextBtn = nextBtn;
        
        ///密码右侧图片
        UIImageView *passwordRightImageView1 = [[UIImageView alloc] init];
        UIImage *passwordRightImage1 = [UIImage imageNamed:@"眼睛1"];
        passwordRightImageView1.image = passwordRightImage1;
        [self addSubview:passwordRightImageView1];
        _passwordRightImageView1 = passwordRightImageView1;
        
        
        UIButton *passwordRight2 = [[UIButton alloc] init];
        [passwordRight2 setBackgroundImage:[UIImage imageNamed:@"眼睛1"] forState:UIControlStateNormal];
        [passwordRight2 setBackgroundImage:[UIImage imageNamed:@"眼睛2"] forState:UIControlStateSelected];
        passwordRight2.selected = YES;
        [passwordRight2 addTarget:self action:@selector(securityPassword) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:passwordRight2];
        _passwordRight2 = passwordRight2;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(SCREEN_HEIGHT * 0.0556);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.0453);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.024);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0229);
    }];
    
    [_barTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(SCREEN_HEIGHT * 0.048);
        make.left.mas_equalTo(_backBtn.mas_right).mas_offset(SCREEN_WIDTH * 0.0293);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.232 * 29/87);
    }];
    
    [_passWordLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1613);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.08);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.848);
        make.height.mas_equalTo(1);
    }];
    
    [_passwordField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1195);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.1573);
        make.width.mas_equalTo(_passWordLine1);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.4827 * 25/181);
    }];
    
    [_passwordImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1232);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.072);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.05);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.05 * 20.92/18.74);
    }];
    
    [_passwordRightImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1281);
        make.right.mas_equalTo(self.mas_right).mas_offset(-SCREEN_WIDTH * 0.073);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.0579);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0131);
    }];
    
    [_placeholder1Error mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1663);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.073);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0209);
    }];
    
    [_placeholder1Empty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1663);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.073);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0209);
    }];
    
    [_passWordLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.2549);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.08);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.848);
        make.height.mas_equalTo(1);
    }];
    
    [_passwordField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.2131);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.1573);
        make.width.mas_equalTo(_passWordLine1);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.4827 * 25/181);
    }];
    
    [_passwordImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.2167);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.072);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.05);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.05 * 20.92/18.74);
    }];
    
    [_passwordRight2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.2192);
        make.right.mas_equalTo(self.mas_right).mas_offset(-SCREEN_WIDTH * 0.073);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.0579);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0131);
    }];
    
    [_placeholder2Error mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.2599);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.073);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0209);
    }];
    
    [_placeholder2Empty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.2599);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.073);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0209);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.3978);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.128);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.7467);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.064);
    }];
    _nextBtn.layer.cornerRadius = _nextBtn.frame.size.height * 26/50;
    
}

- (void)securityPassword {
    if (_passwordRight2.selected == YES) {
        _passwordField2.secureTextEntry = NO;
        _passwordRight2.selected = NO;
    }else {
        _passwordField2.secureTextEntry = YES;
        _passwordRight2.selected = YES;
    }
}

///创建输入框
- (UITextField *)createTextFieldWithFont:(UIFont *)font placeholder:(NSString *)placeholder{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = font;
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = placeholder;
    if (@available(iOS 11.0, *)) {
        textField.textColor = [UIColor colorNamed:@"MGDSafeTextColor"];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:18], NSForegroundColorAttributeName:[UIColor colorNamed:@"MGDSafePlaceholderColor"]}];
        textField.attributedPlaceholder = string;
    } else {
        // Fallback on earlier versions
    }
    return textField;
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

- (void)ClickedNext {
    if ([self.delegate respondsToSelector:@selector(ClickedNext)]) {
        [self.delegate ClickedNext];
    }
}
@end
