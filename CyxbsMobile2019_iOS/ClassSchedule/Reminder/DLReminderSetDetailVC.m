//
//  DLReminderSetDetailVC.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/10.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLReminderSetDetailVC.h"
#import "DLReminderView.h"
#import "DLReminderSetTimeVC.h"
@interface DLReminderSetDetailVC ()
@property (nonatomic, strong) NSString *inputString;
@property (nonatomic, strong) DLReminderView *reminderView;
@end

@implementation DLReminderSetDetailVC
- (void)viewWillAppear:(BOOL)animated{
    self. navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.reminderView];
    // Do any additional setup after loading the view.
}

- (void)didClickNextButton:(UIButton *)button{
    self.inputString = self.reminderView.textFiled.text;
    if (self.inputString) {
        DLReminderSetTimeVC *vc = [[DLReminderSetTimeVC alloc] init];
        vc.noticeString = self.noticeString;
        vc.detailString = self.inputString;
        [self.navigationController pushViewController:vc animated:NO];
    }
    else{
        NSLog(@"未输入");
    }
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

- (DLReminderView *)reminderView{
    if (!_reminderView) {
        _reminderView = [[DLReminderView alloc] init];
        _reminderView.frame = self.view.frame;
        _reminderView.titleLab.text = @"为你的行程添加 具体内容";
        _reminderView.notoiceLab.text = [NSString stringWithFormat:@"标题：%@",self.noticeString];
//        _reminderView.textFiled.delegate = self;
        _reminderView.nextBtn.backgroundColor = [UIColor colorWithHexString:@"#AABBFF"];
        [_reminderView.nextBtn addTarget:self action:@selector(didClickNextButton:) forControlEvents:UIControlEventTouchUpInside];
        [_reminderView.backBtn addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reminderView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
