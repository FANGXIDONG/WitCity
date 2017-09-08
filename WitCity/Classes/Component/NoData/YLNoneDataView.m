//
//  YLNoneDataView.m
//  style_ios
//
//  Created by duyulong on 9/26/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLNoneDataView.h"

@interface YLNoneDataView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation YLNoneDataView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.label];
}

-(void)layout
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(90);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(WINDOW_WIDTH, 60));
    }];
}

-(void)layoutSpecial
{
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(183.3f);
    }];
}
-(void)useStyle
{
    self.label.font = [UIFont systemFontOfSize:17];
    self.label.textColor = [UIColor colorWithHex:0xd8d9da];
    self.label.numberOfLines = 0;
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.backgroundColor = [UIColor whiteColor];
}

-(void)setType:(YLNoneDataViewType)type
{
    switch (type) {
        case kYLNoneDataViewTypeDefault:{
            [self layoutSpecial];
            [self photoWithText:@"暂无数据" imageNamed:@""];
        } break;
        case kYLNoneDataViewTypeCollect:{
            [self photoWithText:@"你还未收藏过任何内容,快去收藏吧" imageNamed:@"no_collect"];
            [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(57, 43));
            }];
        } break;
        case kYLNoneDataViewTypeMessage:{
            [self photoWithText:@"暂无消息" imageNamed:@"no_reply"];
        } break;
        default:
            break;
    }
    
    _type = type;
}

//标题
- (void)cryBabyWithText:(NSString *)text
{
//    self.imageView.image = [UIImage imageNamed:@"ndCryBaby"];
    self.label.text = text;
}

//图片和标题
- (void)photoWithText:(NSString *)text imageNamed:(NSString *)imageNamed
{
    self.imageView.image = [UIImage imageNamed:imageNamed];
    self.label.text = text;
}

@end
