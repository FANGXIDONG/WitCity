//
//  YLEnterpriseCellBootomView.m
//  WitCity
//
//  Created by simpletour on 16/5/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCellBootomView.h"
#import "YLHorizontalButton.h"
#import "UILabel+YLPadding.h"

@interface YLCellBootomView ()

@property (nonatomic, strong) UIView             *line;
@property (nonatomic, strong) UIView             *lineBlock;
@property (nonatomic, strong) UILabel            *lblFlag;
@property (nonatomic, strong) YLHorizontalButton *btnCollect;
@property (nonatomic, strong) YLHorizontalButton *btnReply;

@end

@implementation YLCellBootomView

-(void)addViews
{
    [self addSubview:self.lblFlag];
    [self addSubview:self.btnCollect];
    [self addSubview:self.btnReply];
    [self addSubview:self.line];
    [self addSubview:self.lineBlock];
}

-(void)layout
{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.lineBlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.lblFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).offset(-5);
        make.left.mas_equalTo(16);
//        make.right.mas_equalTo(self.btnCollect.mas_left).offset(-10);
    }];
    
    [self.btnReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.lblFlag);
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(65, 25));
    }];
    
    [self.btnCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.width.and.height.mas_equalTo(self.btnReply);
        make.right.mas_equalTo(self.btnReply.mas_left);
    }];
    
}

-(void)useStyle
{
    self.lblFlag.backgroundColor = kYLColorFontOrange;
    self.lblFlag.textColor = [UIColor whiteColor];
    self.lblFlag.font = [UIFont systemFontOfSize:13];
    self.lblFlag.layer.masksToBounds = YES;
    self.lblFlag.layer.cornerRadius = 4;
    self.lblFlag.hidden = YES;
    self.line.backgroundColor = kYLColorLine;
    self.lineBlock.backgroundColor = kYLColorLine;
    [self.btnCollect setImage:[UIImage imageNamed:@"c_collect_default"] forState:UIControlStateNormal];
    [self.btnCollect setImage:[UIImage imageNamed:@"c_collect_selected"] forState:UIControlStateHighlighted];
    [self.btnCollect setImage:[UIImage imageNamed:@"c_collect_selected"] forState:UIControlStateSelected];
    [self.btnReply setImage:[UIImage imageNamed:@"c_message"] forState:UIControlStateNormal];
    
    self.btnCollect.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 0, 0);
    self.btnReply.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 0, 0);
    [self.btnCollect addTarget:self action:@selector(btnCollectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnReply addTarget:self action:@selector(btnReplyClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lblFlag setEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
}

- (void)btnCollectClick:(UIButton *)button
{
    YLBlockType blockType = button.selected ? kYLBlockTypeCollectCancel : kYLBlockTypeCollectAdd;
    NSInteger val = button.currentTitle.integerValue;
    NSInteger value = button.selected ? (val - 1) : (val + 1);
    [button setTitle:[NSString stringWithFormat:@"%ld", (long)value] forState:UIControlStateNormal];
    button.selected = !button.selected;
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType),
                             }];
}

- (void)btnReplyClick:(UIButton *)button
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeCommentDetail),
                             }];
}

-(void)setType:(YLCellBootomViewType)type
{
    switch (type) {
        case kYLCellBootomViewTypeOnlyCollect:{
            self.lblFlag.hidden = YES;
            self.btnReply.hidden = YES;
            [self.btnCollect mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self).offset(-5);
                make.right.mas_equalTo(-16);
                make.size.mas_equalTo(CGSizeMake(65, 25));
            }];
        }break;
        case kYLCellBootomViewTypeCollectAndFlag:{
            self.lblFlag.hidden = NO;
            self.btnReply.hidden = YES;
            [self.btnCollect mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.lblFlag);
                make.right.mas_equalTo(-16);
                make.size.mas_equalTo(CGSizeMake(65, 25));
            }];
        }break;
        case kYLCellBootomViewTypeCollectAndReply:{
        }break;
        default:
            break;
    }
    _type = type;
}

-(NSString *)collect
{
   return  self.btnCollect.currentTitle;
}

-(NSString *)reply
{
    return self.btnReply.currentTitle;
}

-(void)setCollect:(NSString *)collect
{
    [self.btnCollect setTitle:collect forState:UIControlStateNormal];
}

-(void)setReply:(NSString *)reply
{
    [self.btnReply setTitle:reply forState:UIControlStateNormal];
}

-(void)setFlag:(NSString *)flag
{
    self.lblFlag.text = flag;
}

-(void)setIsCollect:(BOOL)isCollect
{
    _isCollect = isCollect;
    self.btnCollect.selected = isCollect;
}

@end
