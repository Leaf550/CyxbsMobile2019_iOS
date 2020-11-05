//
//  MineContentView.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/10/30.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "MineContentView.h"
#import "MineContentViewProtocol.h"

@interface MineContentView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray<NSDictionary<NSString *, id> *> *settingsArray;
@property (nonatomic, assign) BOOL isFold;

@end

@implementation MineContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
        
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor colorNamed:@"Mine_Main_BackgroundColor"];
        } else {
            // Fallback on earlier versions
        }
        
        // NSArray<NSDictionary<NSString *, id> *> *settingsArray;
        self.settingsArray = @[
            @{
                @"sectionTitle": @"课前提醒",
                @"settings": @[
                    @{
                        @"title": @"上课前提醒我",
                        @"hasSwitch": @YES
                    },
                    @{
                        @"title": @"每天晚上推送课表给我",
                        @"hasSwitch": @YES
                    },
                    @{
                        @"title": @"在没课的地方显示备忘录",
                        @"hasSwitch": @YES
                    }
                ]
            },
            @{
                @"sectionTitle": @"其他设置",
                @"settings": @[
                    @{
                        @"title": @"启动APP时优先显示课表页面",
                        @"hasSwitch": @YES
                    },
                    @{
                        @"title": @"账号与安全",
                        @"hasSwitch": @NO
                    },
                    @{
                        @"title": @"关于",
                        @"hasSwitch": @NO
                    }
                ]
            }
        ];
        
        // 添加课前提醒TableView
        UITableView *classScheduleSettingsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H) style:UITableViewStyleGrouped];
        classScheduleSettingsTable.layer.cornerRadius = 16;
        classScheduleSettingsTable.delegate = self;
        classScheduleSettingsTable.dataSource = self;
        classScheduleSettingsTable.backgroundColor = self.backgroundColor;
        classScheduleSettingsTable.rowHeight = 55;
        classScheduleSettingsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        classScheduleSettingsTable.showsVerticalScrollIndicator = NO;
        [self addSubview:classScheduleSettingsTable];
        self.classScheduleTableView = classScheduleSettingsTable;
        
        // 添加headerView（个人信息相关）
        MineHeaderView *headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_W * 0.776)];
        classScheduleSettingsTable.tableHeaderView = headerView;
        self.headerView = headerView;
        [headerView.editButton addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [headerView.signinButton addTarget:self action:@selector(checkInButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *questionLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionLabelClicked)];
        [headerView.questionsNumberLabel addGestureRecognizer:questionLabelGesture];
        
        UITapGestureRecognizer *answerLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(answerLabelClicked)];
        [headerView.answerNumberLabel addGestureRecognizer:answerLabelGesture];
        
        UITapGestureRecognizer *responseLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(responseLabelClicked)];
        [headerView.responseNumberLabel addGestureRecognizer:responseLabelGesture];
        
        
        // 添加FooterView（APP设置TableView）
        UITableView *appSettingTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 55 * ((NSArray *)(self.settingsArray[1][@"settings"])).count + 168) style:UITableViewStyleGrouped];
        appSettingTabelView.delegate = self;
        appSettingTabelView.dataSource = self;
        appSettingTabelView.backgroundColor = self.backgroundColor;
        appSettingTabelView.rowHeight = 55;
        appSettingTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        appSettingTabelView.showsVerticalScrollIndicator = NO;
        appSettingTabelView.scrollEnabled = NO;
        self.appSettingTableView = appSettingTabelView;
        classScheduleSettingsTable.tableFooterView = appSettingTabelView;
        
        
        UIView *appSettingTableViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 127)];
        appSettingTableViewFooter.backgroundColor = [UIColor clearColor];
        self.appSettingTableView.sectionFooterHeight = 10;
        appSettingTabelView.tableFooterView = appSettingTableViewFooter;
        
        UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [quitButton setTitle:@"退 出 登 录" forState:UIControlStateNormal];
        [quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        quitButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [quitButton addTarget:self action:@selector(quitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [appSettingTableViewFooter addSubview:quitButton];
        [quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(appSettingTableViewFooter);
            make.centerX.equalTo(appSettingTableViewFooter);
            make.width.equalTo(self.mas_width).multipliedBy(0.49);
            make.height.equalTo(@40);
        }];
        quitButton.layer.cornerRadius = 20;
        
        if (@available(iOS 11.0, *)) {
            quitButton.backgroundColor = [UIColor colorNamed:@"Mine_Main_ButtonColor"];
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}


#pragma mark - TableVIew数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.classScheduleTableView) {
        if (self.isFold) {
            return 0;
        } else {
            return ((NSArray *)(self.settingsArray[0][@"settings"])).count;;
        }
    } else {
        return ((NSArray *)(self.settingsArray[1][@"settings"])).count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    
    cell.backgroundColor = tableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (@available(iOS 11.0, *)) {
        cell.textLabel.textColor = [UIColor colorNamed:@"Mine_Main_LabelColor"];
    } else {
        // Fallback on earlier versions
    }
    
    if (tableView == self.classScheduleTableView) {
        cell.textLabel.text = ((NSArray *)(self.settingsArray[0][@"settings"]))[indexPath.row][@"title"];
        
        // 添加开关
        if ([((NSArray *)(self.settingsArray[0][@"settings"]))[indexPath.row][@"hasSwitch"] boolValue]) {
            UISwitch *settingSwitch = [[UISwitch alloc] init];
            settingSwitch.frame = CGRectMake(MAIN_SCREEN_W - 80, 11.5, 53, 27);
            if (@available(iOS 11.0, *)) {
                settingSwitch.onTintColor = [UIColor colorNamed:@"Mine_Main_SwitchBackground_On"];
            } else {
                settingSwitch.onTintColor = [UIColor colorWithRed:41/255.0 green:33/255.0 blue:214/255.0 alpha:1.0];
            }
            if (@available(iOS 11.0, *)) {
                settingSwitch.backgroundColor = [UIColor colorNamed:@"Mine_Main_SwitchBackground_Off"];
            } else {
                settingSwitch.backgroundColor = [UIColor colorWithRed:195/255.0 green:212/255.0 blue:238/255.0 alpha:1.0];
            }
            settingSwitch.layer.cornerRadius = settingSwitch.height / 2.0;
            [cell.contentView addSubview:settingSwitch];
            
            if ([cell.textLabel.text hasPrefix:@"上课前"]) {
                [settingSwitch addTarget:self action:@selector(switchedRemindBeforeClass:) forControlEvents:UIControlEventValueChanged];
                if ([UserDefaultTool valueWithKey:@"Mine_RemindBeforeClass"]) {
                    settingSwitch.on = YES;
                    // 在这里读取缓存，设置cell的text
                }
            } else if ([cell.textLabel.text hasPrefix:@"每天"]) {
                [settingSwitch addTarget:self action:@selector(switchedRemindEveryDay:) forControlEvents:UIControlEventValueChanged];
                if ([UserDefaultTool valueWithKey:@"Mine_RemindEveryDay"]) {
                    settingSwitch.on = YES;
                    // 在这里读取缓存，设置cell的text
                }
            } else if ([cell.textLabel.text hasPrefix:@"在没课的地方显示备忘录"]) {
                [settingSwitch addTarget:self action:@selector(switchedDisplayMemoPad:) forControlEvents:UIControlEventValueChanged];
                if ([UserDefaultTool valueWithKey:@"Mine_DisplayMemoPad"]) {
                    settingSwitch.on = YES;
                    // 在这里读取缓存，设置cell的text
                }
            }
        }
    } else {
        cell.textLabel.text = ((NSArray *)(self.settingsArray[1][@"settings"]))[indexPath.row][@"title"];
        
        // 添加开关
        if ([((NSArray *)(self.settingsArray[1][@"settings"]))[indexPath.row][@"hasSwitch"] boolValue]) {
            UISwitch *settingSwitch = [[UISwitch alloc] init];
            settingSwitch.frame = CGRectMake(MAIN_SCREEN_W - 80, 11.5, 53, 27);
            if (@available(iOS 11.0, *)) {
                settingSwitch.onTintColor = [UIColor colorNamed:@"Mine_Main_SwitchBackground_On"];
            } else {
                settingSwitch.onTintColor = [UIColor colorWithRed:41/255.0 green:33/255.0 blue:214/255.0 alpha:1.0];
            }
            if (@available(iOS 11.0, *)) {
                settingSwitch.backgroundColor = [UIColor colorNamed:@"Mine_Main_SwitchBackground_Off"];
            } else {
                settingSwitch.backgroundColor = [UIColor colorWithRed:195/255.0 green:212/255.0 blue:238/255.0 alpha:1.0];
                
            }
            settingSwitch.layer.cornerRadius = settingSwitch.height / 2.0;
            [cell.contentView addSubview:settingSwitch];
            if ([cell.textLabel.text hasPrefix:@"启动"]) {
                [settingSwitch addTarget:self action:@selector(switchedLaunchingWithClassScheduleView:) forControlEvents:UIControlEventValueChanged];
                if ([UserDefaultTool valueWithKey:@"Mine_LaunchingWithClassScheduleView"]) {
                    settingSwitch.on = YES;
                    // 在这里读取缓存，设置cell的text
                }
            }
        }
    }
    
    return  cell;
}

# pragma mark - TableView代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath]; 
    if ([selectedCell.textLabel.text isEqualToString:@"关于"]) {
        if ([self.delegate respondsToSelector:@selector(selectedAboutCell)]) {
            [self.delegate selectedAboutCell];
        }
    }else if ([selectedCell.textLabel.text isEqualToString:@"账号与安全"]) {
        if ([self.delegate respondsToSelector:@selector(selectedSafeCell)]) {
            [self.delegate selectedSafeCell];
        }
    }
}


// Section的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.classScheduleTableView) {
        tableView.sectionHeaderHeight = 54;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 32)];
        headerView.backgroundColor = self.backgroundColor;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 70, 21)];
        titleLabel.text = self.settingsArray[section][@"sectionTitle"];
        titleLabel.font = [UIFont systemFontOfSize:15];
        if (@available(iOS 11.0, *)) {
            titleLabel.textColor = [UIColor colorNamed:@"Mine_Main_TitleColor"];
        } else {
            titleLabel.textColor = [UIColor colorWithRed:17/255.0 green:44/255.0 blue:84/255.0 alpha:1.0];
        }
        [headerView addSubview:titleLabel];
        
        UIButton *foldButton = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_W - 27 - 19, 15, 22, 22)];
        foldButton.imageEdgeInsets = UIEdgeInsetsMake(7, 3, 7, 3);
        [foldButton setImage:[UIImage imageNamed:@"我的主页箭头"] forState:UIControlStateNormal];
        if (self.isFold) {
            foldButton.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
        [foldButton addTarget:self action:@selector(foldButtonClicked:foldState:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:foldButton];
        
        return headerView;
    } else {
        tableView.sectionHeaderHeight = 24;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 22)];
        headerView.backgroundColor = tableView.backgroundColor;
        UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, 1.5)];
        if (@available(iOS 11.0, *)) {
            separateLine.backgroundColor = [UIColor colorNamed:@"Mine_Main_SeparateLineColor"];
        } else {
            separateLine.backgroundColor = [UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:0.1];
        }
        [headerView addSubview:separateLine];
        return headerView;
    }
}


#pragma mark - 按钮回调
- (void)editButtonClicked {
    if ([self.delegate respondsToSelector:@selector(editButtonClicked)]) {
        [self.delegate editButtonClicked];
    }
}

- (void)checkInButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(checkInButtonClicked:)]) {
        [self.delegate checkInButtonClicked:sender];
    }
}

- (void)foldButtonClicked:(UIButton *)foldButton foldState:(BOOL)isFold {
    if ([self.delegate respondsToSelector:@selector(foldButtonClicked:foldState:)]) {
        [UserDefaultTool saveValue:@(![[UserDefaultTool valueWithKey:@"Mine_isFold"] boolValue]) forKey:@"Mine_isFold"];
        [self.delegate foldButtonClicked:foldButton foldState:self.isFold];
    }
}

- (void)quitButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(quitButtonClicked:)]) {
        [self.delegate quitButtonClicked:sender];
    }
}

- (void)switchedRemindBeforeClass:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(switchedRemindBeforeClass:)]) {
        [self.delegate switchedRemindBeforeClass:sender];
    }
}

- (void)switchedRemindEveryDay:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(switchedRemindEveryDay:)]) {
        [self.delegate switchedRemindEveryDay:sender];
    }
}

- (void)switchedDisplayMemoPad:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(switchedDisplayMemoPad:)]) {
        [self.delegate switchedDisplayMemoPad:sender];
    }
}

- (void)switchedLaunchingWithClassScheduleView:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(switchedLaunchingWithClassScheduleView:)]) {
        [self.delegate switchedLaunchingWithClassScheduleView:sender];
    }
}

- (void)answerLabelClicked {
    if ([self.delegate respondsToSelector:@selector(answerLabelClicked)]) {
        [self.delegate answerLabelClicked];
    }
}

- (void)questionLabelClicked {
    if ([self.delegate respondsToSelector:@selector(questionLabelClicked)]) {
        [self.delegate questionLabelClicked];
    }
}

- (void)responseLabelClicked {
    if ([self.delegate respondsToSelector:@selector(responseLabelClicked)]) {
        [self.delegate responseLabelClicked];
    }
}


#pragma mark - getter, setter
- (BOOL)isFold {
    BOOL Mine_isFold = [[UserDefaultTool valueWithKey:@"Mine_isFold"] boolValue];
    if (!Mine_isFold) {
        [UserDefaultTool saveValue:@NO forKey:@"Mine_isFold"];
        _isFold = NO;
    } else {
        _isFold = Mine_isFold;
    }
    return _isFold;
}

@end
