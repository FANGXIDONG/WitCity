//
//  YLShareView.m
//  FJZ
//
//  Created by duyulong on 11/15/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLShareView.h"

#define kContentViewHeigt (120)

@interface YLShareView()

@property (nonatomic, strong) UIView          *bgView;
@property (nonatomic, strong) UIView          *contentView;
@property (nonatomic, strong) YLShareItemView *itemWeChatFriend;
@property (nonatomic, strong) YLShareItemView *itemWeChatCycle;
@property (nonatomic, strong) UIView          *line;
@property (nonatomic, strong) UIButton        *btnClose;

@end

@implementation YLShareView

-(void)addViews
{
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.itemWeChatFriend];
    [self.contentView addSubview:self.itemWeChatCycle];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.btnClose];
}

-(void)layout
{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.itemWeChatFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(-50);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(80);
    }];
    
    [self.itemWeChatCycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.mas_equalTo(self.itemWeChatFriend);
        make.left.mas_equalTo(self.itemWeChatFriend.mas_right).offset(50);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.itemWeChatCycle.mas_bottom);
        make.height.mas_equalTo(2);
    }];
    
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(kContentViewHeigt);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.line.backgroundColor = kYLColorLine;
    self.btnClose.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btnClose setTitle:@"关闭" forState:UIControlStateNormal];
    [self.btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.itemWeChatFriend updateWithTitle:@"微信好友" imageNamed:@"sWeiChat"];
    [self.itemWeChatCycle updateWithTitle:@"朋友圈" imageNamed:@"sFrendsCircel"];
    [self.itemWeChatFriend addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weChatFriendClick:)]];
    [self.itemWeChatCycle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weChatCycleClick:)]];
    [self.btnClose addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show
{
    self.hidden = NO;
    self.bgView.alpha = 0.0f;
    self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y + kContentViewHeigt);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.5f;
        self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y - kContentViewHeigt);
    }];
}

- (void)hide
{
    self.bgView.alpha = 0.5f;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.0f;
        self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y + kContentViewHeigt);
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
            self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y - kContentViewHeigt);
        }
    }];
}

- (void)weChatCycleClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeShareWeChatCycle)
                             }];
}

- (void)weChatFriendClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeShareWeChatFriend)
                             }];
}

- (void)btnCloseClick:(UIButton *)button
{
    [self hide];
}


@end









@interface YLShareItemView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation YLShareItemView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.lblTitle];
}

-(void)layout
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(10);
        make.width.and.height.mas_equalTo(40);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(5);
        make.left.and.right.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.lblTitle.font = [UIFont systemFontOfSize:12];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
}

- (void)updateWithTitle:(NSString *)title imageNamed:(NSString *)imageNamed
{
    self.lblTitle.text = title;
    self.imageView.image = [UIImage imageNamed:imageNamed];
}

@end
