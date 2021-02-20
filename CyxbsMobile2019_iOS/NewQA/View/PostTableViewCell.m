//
//  PostTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/12/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "PostTableViewCell.h"
#import "MGDImageCollectionViewCell.h"
#import "PostModel.h"
#import "StarPostModel.h"
#import <YBImageBrowser.h>


#define Pading SCREEN_WIDTH*0.0427
#define Margin 5
#define item_num 3

@interface PostTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *attributes;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation PostTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor colorNamed:@"TableViewBackColor"];
        } else {
            // Fallback on earlier versions
        }
        [self BuildUI];
        [self BuildFrame];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)BuildUI {
    ///头像
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    
    ///昵称
    _nicknameLabel = [[UILabel alloc] init];
    _nicknameLabel.textAlignment = NSTextAlignmentLeft;
    _nicknameLabel.font = [UIFont fontWithName:@"PingFangSC-Heavy" size: 15];
    if (@available(iOS 11.0, *)) {
        _nicknameLabel.textColor = [UIColor colorNamed:@"CellUserNameColor"];
    } else {
        // Fallback on earlier versions
    }
    [self.contentView addSubview:_nicknameLabel];
    
    ///时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 11];
    if (@available(iOS 11.0, *)) {
        _timeLabel.textColor = [UIColor colorNamed:@"CellDateColor"];
    } else {
        // Fallback on earlier versions
    }
    [self.contentView addSubview:_timeLabel];
    
    ///多功能按钮
    _funcBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _funcBtn.backgroundColor = [UIColor clearColor];
    [_funcBtn setBackgroundImage:[UIImage imageNamed:@"QAMoreButton"] forState:UIControlStateNormal];
    [_funcBtn addTarget:self action:@selector(ClickedFuncBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_funcBtn];
    
    ///内容
    _detailLabel = [[UILabel alloc] init];
    if (@available(iOS 11.0, *)) {
        _detailLabel.textColor = [UIColor colorNamed:@"CellDetailColor"];
    } else {
        // Fallback on earlier versions
    }
    self.detailLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    self.detailLabel.backgroundColor = [UIColor clearColor];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    // 多行设置
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.preferredMaxLayoutWidth = (SCREEN_WIDTH - Pading * 2);
    [self.detailLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentView addSubview:_detailLabel];

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor clearColor];
    _collectView.delegate=self;
    _collectView.dataSource=self;
    [_collectView registerClass:[MGDImageCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.contentView addSubview:_collectView];
    
    ///标签
    _groupLabel = [[UIButton alloc] init];
    _groupImage = [UIImage imageNamed:@"标签背景"];
    [_groupLabel setBackgroundImage:_groupImage forState:UIControlStateNormal];
    _groupLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_groupLabel.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size: 12.08]];
    if (@available(iOS 11.0, *)) {
        [_groupLabel setTitleColor:[UIColor colorNamed:@"CellGroupColor"] forState:UIControlStateNormal];
    } else {
        // Fallback on earlier versions
    }
    [self.contentView addSubview:_groupLabel];
    
    ///点赞
    _starBtn = [[FunctionBtn alloc] init];
    [_starBtn addTarget:self action:@selector(ClickedStar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_starBtn];
    
    ///评论
    _commendBtn = [[FunctionBtn alloc] init];
    _commendBtn.iconView.image = [UIImage imageNamed:@"answerIcon"];
    [_commendBtn addTarget:self action:@selector(ClickedComment:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commendBtn];
    
    ///分享
    _shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _shareBtn.backgroundColor = [UIColor clearColor];
    [_shareBtn setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(ClickedShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_shareBtn];
    
}

- (void)BuildFrame {
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(SCREEN_WIDTH * 0.0427);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(SCREEN_WIDTH * 0.0427);
        make.width.height.mas_equalTo(SCREEN_WIDTH * 0.1066);
    }];
    _iconImageView.layer.cornerRadius = SCREEN_WIDTH * 0.1066 * 1/2;
    
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(SCREEN_WIDTH * 0.0427 + 2);
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(SCREEN_WIDTH * 0.04);
        make.right.mas_equalTo(self.funcBtn.mas_right).mas_offset(-SCREEN_WIDTH * 0.04);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.1381 * 14.5/43.5);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nicknameLabel.mas_bottom).mas_offset(9);
        make.left.right.mas_equalTo(self.nicknameLabel);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.1794 * 9/56.5);
    }];
    
    [_funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(SCREEN_HEIGHT * 0.051);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(SCREEN_WIDTH * 0.89);
        make.width.mas_equalTo([UIImage imageNamed:@"QAMoreButton"].size.width);
        make.height.mas_equalTo([UIImage imageNamed:@"QAMoreButton"].size.height);
    }];
    
    [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.021);
        make.left.mas_equalTo(self.iconImageView);
        make.right.mas_equalTo(self.mas_right).mas_offset(-SCREEN_WIDTH * 0.0427);
    }];
    
    [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_detailLabel.mas_bottom).mas_offset(Pading * 13.5/16);
        make.left.mas_equalTo(_detailLabel);
        make.width.mas_equalTo(SCREEN_WIDTH - Pading * 2);
        make.height.mas_equalTo(1).priorityLow();
    }];
    
    [_groupLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectView.mas_bottom).mas_offset(11);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-Pading * 62.5/16);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(SCREEN_WIDTH * 0.0413);
        make.width.mas_equalTo(_groupImage.size);
    }];

    _groupLabel.layer.cornerRadius = 1/2 * _groupImage.size.height * 1/2;

    
    [_starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groupLabel.mas_bottom).mas_offset(SCREEN_WIDTH * 0.5653 * 20.5/212);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.0535 * 20.75/20.05);

        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(SCREEN_WIDTH * 0.5587);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.1648);
    }];
    
    [_commendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self.starBtn);
        make.left.mas_equalTo(self.starBtn.mas_right).mas_offset(SCREEN_WIDTH * 0.01);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.starBtn);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.0547);
        make.right.mas_equalTo(self.mas_right).mas_offset(-SCREEN_WIDTH * 0.0427);
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- setter
- (void)setItem:(PostItem *)item {
    if (item) {
        _item = item;
        self.iconImageView.image = [UIImage imageNamed:@"圈子图像"];
//        self.nicknameLabel.text = item.nick_name;
        self.nicknameLabel.text = @"测试name";
        self.timeLabel.text = [self getDateStringWithTimeStr:[NSString stringWithFormat:@"%@",item.publish_time]];
        self.detailLabel.text = item.content;
        [self.groupLabel setTitle:[NSString stringWithFormat:@"# %@",item.topic] forState:UIControlStateNormal];

        NSString *content = self.groupLabel.titleLabel.text;
        UIFont *font = self.groupLabel.titleLabel.font;
        CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
        CGSize buttonSize = [content boundingRectWithSize:size
        options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        attributes:@{ NSFontAttributeName:font}
        context:nil].size;
        [_groupLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.collectView.mas_bottom).mas_offset(11);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-Pading * 62.5/16);
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(SCREEN_WIDTH * 0.0413);
            make.width.mas_equalTo(buttonSize.width + SCREEN_WIDTH * 0.05 * 2);
        }];

        self.commendBtn.countLabel.text = [NSString stringWithFormat:@"%@",item.comment_count];
        self.starBtn.countLabel.text = [NSString stringWithFormat:@"%@",item.praise_count];
        self.starBtn.selected = [item.is_praised intValue] == 1 ? YES : NO;
        if (@available(iOS 11.0, *)) {
            self.starBtn.countLabel.textColor = self.starBtn.selected == YES ? [UIColor colorNamed:@"countLabelColor"] : [UIColor colorNamed:@"FuncBtnColor"];
            self.commendBtn.countLabel.textColor = [UIColor colorNamed:@"FuncBtnColor"];
        } else {
            // Fallback on earlier versions
        }
        [self.starBtn setIconViewSelectedImage:[UIImage imageNamed:@"点赞"] AndUnSelectedImage:[UIImage imageNamed:@"未点赞"]];
        [self reloadCell:item.pics];
    }
}

- (void)reloadCell:(NSArray *)imgarr{
    [self.collectView reloadData];
    [self.collectView layoutIfNeeded];
    [self.collectView setNeedsLayout];
    CGFloat height_pading;
    CGFloat height_collectionview;
    if (imgarr.count == 0) {
        height_pading = 0;
        height_collectionview = 5;
    }else {
        height_pading = 13.5;
        height_collectionview = self.collectView.collectionViewLayout.collectionViewContentSize.height;
    }
    [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailLabel.mas_bottom).mas_offset(height_pading);
        make.left.mas_equalTo(_detailLabel);
        make.width.mas_equalTo(SCREEN_WIDTH - 2 * Pading);
        make.height.mas_equalTo(height_collectionview);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *tagsArr = _item.pics;
    if (tagsArr.count > 3) {
        return 3;
    }
    return tagsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGDImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    NSArray *tagsArr = _item.pics;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:tagsArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"zahnweitu"]];
    
    if (indexPath.row == 2 && tagsArr.count > 3) {
        unsigned long diff = tagsArr.count - 3;
        NSString *count = [NSString stringWithFormat:@"+%lu",diff];
        cell.countLabel.text = count;
        cell.countLabel.hidden = NO;
    }
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat item_height = (SCREEN_WIDTH-(2 * Margin + Pading * 2))/item_num;
    CGSize size = CGSizeMake(item_height,item_height);
    return size;
}

//这个是两行cell之间的最小间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//两个cell之间的最小间距间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0;i < [_item.pics count]; i++) {
        YBIBImageData *data = [YBIBImageData new];
        data.imageURL = [NSURL URLWithString:_item.pics[i]];
        [photos addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = photos;
    browser.currentPage = indexPath.row;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser show];
}



///时间戳转具体日期
- (NSString *)getDateStringWithTimeStr:(NSString *)str{
   NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]];
   NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
   [formatter setDateFormat:@"YYYY-MM-dd"];
   NSString *timeStr=[formatter stringFromDate:myDate];
   return timeStr;
}

- (void)ClickedFuncBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ClickedFuncBtn:)]) {
        [self.delegate ClickedFuncBtn:sender];
    }
}

///点赞的逻辑：点赞后，本地改变点赞的数值，然后通过网络请求传入后端
- (void)ClickedStar:(FunctionBtn *)sender {
    if ([self.delegate respondsToSelector:@selector(ClickedStarBtn:)]) {
        [self.delegate ClickedStarBtn:sender];
    }
}

///跳转到具体的评论界面
- (void)ClickedComment:(FunctionBtn *)sender {
    if ([self.delegate respondsToSelector:@selector(ClickedCommentBtn:)]) {
        [self.delegate ClickedCommentBtn:sender];
    }
}

///分享
- (void)ClickedShare:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ClickedShareBtn:)]) {
        [self.delegate ClickedShareBtn:sender];
    }
}

///点击标签跳转进相应的圈子
- (void)ClickedGroupTopicBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ClickedGroupTopicBtn:)]) {
        [self.delegate ClickedGroupTopicBtn:sender];
    }
}
@end

