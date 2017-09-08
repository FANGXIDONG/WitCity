//
//  DDPublishLwqButtomView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishLwqButtomView.h"

@interface DDPublishLwqButtomView()

@property (nonatomic, strong) UIButton *publishBtn;
@end

@implementation DDPublishLwqButtomView

-(void)addViews{
    [self addSubview:self.publishBtn];
}

-(void)layout{
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(50);
    }];
}

-(void)useStyle{
    self.backgroundColor = kYLColorBakcgorund;
    self.publishBtn.backgroundColor = kDDColorSkyBlue;
    self.publishBtn.layer.cornerRadius = 7;
    self.publishBtn.layer.masksToBounds = YES;
    [self.publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal    ];
    [self.publishBtn addTarget:self action:@selector(lwqPublishAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)lwqPublishAction:(UIButton *)sender{
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypePublishAction)
                             }];
}
@end








