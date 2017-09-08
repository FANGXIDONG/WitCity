
//
//  DDEditFooterView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/27.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEditDataFooterView.h"

@interface DDEditDataFooterView()
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation DDEditDataFooterView

-(void)addViews{
    [self addSubview:self.submitBtn];
}
-(void)layout{
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
}
-(void)useStyle{
    self.submitBtn.backgroundColor = [UIColor whiteColor];
    [self.submitBtn setTitle:@"审核" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    self.submitBtn.layer.cornerRadius = 3;
    self.submitBtn.layer.borderColor = kDDColorGrayText.CGColor;
    self.submitBtn.layer.borderWidth = 1;
    [self.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)submitAction{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeDataSubmit),
                             }];
}
@end





