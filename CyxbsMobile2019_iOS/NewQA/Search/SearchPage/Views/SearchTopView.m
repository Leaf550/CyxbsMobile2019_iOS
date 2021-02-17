//
//  SearchTopView.m
//  CyxbsMobile2019_iOS
//
//  Created by 石子涵 on 2021/1/25.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "SearchTopView.h"
@interface SearchTopView()
/// 计时器
@property (nonatomic, strong) NSTimer *timer;

/// 用于秒数计时
@property (nonatomic) int second;

/// 用于轮播的序数
@property (nonatomic, assign) int i;


@property (nonatomic, strong) UIImageView *searchFieldBackgroundView;
@end
@implementation SearchTopView
#pragma mark- life Cycle
- (instancetype)init{
    self = [super init];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor colorNamed:@"SZHMainBoardColor"];
        } else {
            // Fallback on earlier versions
        }
        self.searchTextfield.placeholder = [NSString stringWithFormat:@"大家都在搜%@",self.placeholderArray[0]];;
        //设置placeholder轮播
        self.second = 0;
        self.i = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cycle) userInfo:nil repeats:YES];
    }
    return self;
}

/// 将这些控件添加到屏幕上并为这些控件设置布局
- (void)layoutSubviews{
    //返回按钮
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(MAIN_SCREEN_W * 0.0427);
        make.top.equalTo(self.mas_top).offset(MAIN_SCREEN_H * 0.0217);
                //高是宽的两倍
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_W * 0.0186, 2 *MAIN_SCREEN_W * 0.0186 ));
    }];
    
    //搜索视图
        //1.添加背景view到屏幕上并设置布局
    [self addSubview:self.searchFieldBackgroundView];
    [self.searchFieldBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.backBtn.mas_right).offset(MAIN_SCREEN_W * 0.0693);
        make.right.equalTo(self.mas_right).offset(-MAIN_SCREEN_W * 0.0426);
    }];
        //2.添加搜索图标
    [self.searchFieldBackgroundView addSubview:self.searchIcon];
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchFieldBackgroundView.mas_left).offset(MAIN_SCREEN_W * 0.0453);
        make.top.equalTo(self.searchFieldBackgroundView.mas_top).offset(MAIN_SCREEN_H * 0.0134);
        make.size.mas_equalTo(CGSizeMake(MAIN_SCREEN_W * 0.0533, MAIN_SCREEN_W * 0.0533));
    }];
        //3.添加搜索框
    [self.searchFieldBackgroundView addSubview:self.searchTextfield];
    [self.searchTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchIcon.mas_right).offset(MAIN_SCREEN_W * 0.032);
        make.right.equalTo(self.searchFieldBackgroundView.mas_right).offset(-10);
        make.centerY.equalTo(self.searchFieldBackgroundView);
    }];
}

#pragma mark- evet response

/// 循环轮播搜索框词组
- (void)cycle{
    self.second++;      //开始计时
    if (self.second % 3 == 0) {     //每3秒轮播一次内容
        self.i++;
        [UIView transitionWithView:self.searchTextfield
                          duration:0.25f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
            self.searchTextfield.placeholder = [NSString stringWithFormat:@"大家都在搜%@",self.placeholderArray[self.i]];
          } completion:nil];
        //以此不断循环轮播内容
        if (self.i == 2) {
            self.i = -1;
        }
    }
}



#pragma mark- getter
- (UIButton *)backBtn{
    if (_backBtn == nil) {
        //
        _backBtn = [[UIButton alloc] init];
            //设置图片
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"返回的小箭头"] forState:UIControlStateNormal];
        //添加方法，跳回返回界面
        [_backBtn addTarget:self.delegate action:@selector(jumpBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIImageView *)searchIcon{
    if (_searchIcon == nil) {
        _searchIcon = [[UIImageView alloc] init];
        _searchIcon.image = [UIImage imageNamed:@"放大镜"];
    }
    return _searchIcon;
}

- (UITextField *)searchTextfield{
    if (_searchTextfield == nil) {
        _searchTextfield = [[UITextField alloc] init];
        //设置字体
        self.searchTextfield.font = [UIFont fontWithName:PingFangSCMedium size:14];
        
            //字体颜色
        if (@available(iOS 11.0, *)) {
            _searchTextfield.textColor = [UIColor colorNamed:@"SZHSearchTextColor"];
        } else {
            // Fallback on earlier versions
        }
       _searchTextfield.backgroundColor = [UIColor clearColor];
    }
    return _searchTextfield;
}

- (UIView *)searchFieldBackgroundView{
    if (_searchFieldBackgroundView == nil) {
        _searchFieldBackgroundView = [[UIImageView alloc] init];
        _searchFieldBackgroundView.image = [UIImage imageNamed:@"搜索框背景图"];
        _searchFieldBackgroundView.userInteractionEnabled = YES;
    }
    return _searchFieldBackgroundView;
}

- (NSArray *)placeholderArray{
    if (_placeholderArray == nil) {
        _placeholderArray = @[@"红岩",@"考研",@"啦啦操"];
    }
    return _placeholderArray;
}

@end
