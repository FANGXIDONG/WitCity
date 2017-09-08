//
//  DDTextFieldWithSelectedItem.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/16.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDTextFieldWithSelectedItem.h"
#import "DDSelectedView.h"
#import "DDSINumberModel.h"

@interface DDTextFieldWithSelectedItem()
@property (nonatomic, strong) UIView  *leftCustomView;
@property (nonatomic, strong) UIView  *line;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) DDSelectedView *sView;
@property (nonatomic, strong) DDSINumberModel *model;
@end
@implementation DDTextFieldWithSelectedItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self addViews];
        [self useStyle];
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor whiteColor];
        
        self.model = [[DDSINumberModel alloc] init];
        self.model.flag = @"医保号";
//        self.model.siNumber = self.text;
    }
    return self;
}

- (void)addViews
{
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, WINDOW_WIDTH, 1)];
    self.line.backgroundColor = kYLColorLine;
    [self addSubview:self.line];
    
    self.leftCustomView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 90, 44)];
    self.sView  = [[DDSelectedView alloc] initWithFrame:self.leftCustomView.frame];
    [self.leftCustomView addSubview:self.sView ];

    _isSelected = NO;
    
    [self.sView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedTap:)]];
}

- (void)allBlockWithDict:(NSDictionary *)dict
{
    if(self.allBlock) {
        self.allBlock(dict);
    }
}


-(void)selectedTap:(UITapGestureRecognizer *)tap{
    
     _isSelected = YES;
    
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDPopPickerViewAction),
                             kYLModel:self.model,
                             }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sView.iv.transform = CGAffineTransformMakeRotation(-M_PI);
    } completion:^(BOOL finished) {
    }];
  

}

- (void)useStyle
{
    self.leftView = self.leftCustomView;
    self.leftViewMode = UITextFieldViewModeAlways;

}

#pragma mark - setter

-(void)setString:(NSString *)string{
    
    self.sView.str = string;
    
    if ([string isEqualToString:@"医保号"]) {
        self.validateType = kDDTextFieldTypeSinumber;
        self.model.flag = @"医保号";
//        self.model.siNumber =  self.text;
    }
    if ([string isEqualToString:@"医保卡号"]) {
        self.validateType = kDDTextFieldTypeSiCardnumber;
        self.model.flag = @"医保卡号";
//        self.model.sicardNumber =  self.text;
    }
}

-(void)setIsHideLine:(BOOL)isHideLine
{
    self.line.hidden = isHideLine;
}


#pragma mark 输入中文
- (BOOL) deptNameInputShouldChinese
{
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:self.text]) {
        return YES;
    }
    return NO;
}


//判断全数字：

- (BOOL) deptNumInputShouldNumber
{
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:self.text]) {
        return YES;
    }
    return NO;
}
//判断全字母：

- (BOOL) deptPassInputShouldAlpha
{
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:self.text]) {
        return YES;
    }
    return NO;
}


//判断仅输入字母或数字：

- (BOOL) deptIdInputShouldAlphaNum
{
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:self.text]) {
        return YES;
    }
    return NO;
}
@end
