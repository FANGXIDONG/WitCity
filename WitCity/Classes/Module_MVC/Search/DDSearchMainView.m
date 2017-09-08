//
//  DDSearchMainView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/1/4.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDSearchMainView.h"
#import "DDCommonView.h"

@interface DDSearchMainView()

@end

@implementation DDSearchMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMain];
    }
    return self;
}

-(void)setupMain{
    self.backgroundColor = kYLColorBakcgorund;
    int maxCols = 3;
    CGFloat buttonStartY = 0;
    CGFloat buttonStartX = 0;
    float width = WINDOW_WIDTH/3;
    NSArray *titleArr = @[@"公司名称",@"注册类型",@"行业类别",@"法人名称",@"经营范围",@"注册资本"];
    NSArray *imageArr = @[@"search_company",@"search_rType",@"search_instury",@"search_faren",@"search_runRange",@"search_rAccount"];
    for (int i = 0; i < titleArr.count; i ++) {
        DDCommonView *commonView = [[DDCommonView alloc] init];
        commonView.title = titleArr[i];
        commonView.imageNamed = imageArr[i];
        commonView.backgroundColor = kYLColorBakcgorund;
        int col = i % maxCols;
        int row = i / maxCols;
        commonView.width = width;
        commonView.height = width;
        commonView.x = buttonStartX + col * width;
        commonView.y = buttonStartY + row * width;
        [self addSubview:commonView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contactTypeTap:)];
        commonView.tag = i+10;
        [commonView addGestureRecognizer:tap];
    }
}
-(void)contactTypeTap:(UITapGestureRecognizer *)tap{

    YLBlockType blockType;
    //公司名称
    if ([tap view].tag == 10) {
        blockType = kDDBlockTypeCompany;
    }
    //注册类型
   else if ([tap view].tag == 11) {
        blockType = kDDBlockTypeRegisterType;
    }
    //行业类别
   else if ([tap view].tag == 12) {
        blockType = kDDBlockTypeIndustry;
    }
    //法人名称
   else if ([tap view].tag == 13) {
        blockType = kDDBlockTypeLegalPerson;
    }
    //经营范围
   else if ([tap view].tag == 14) {
        blockType = kDDBlockTypeBusinessScope;
    }
    //注册资本
    else {
        blockType = kDDBlockTypeRegisterCapital;
    }

    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType)
                             }];
}


@end







