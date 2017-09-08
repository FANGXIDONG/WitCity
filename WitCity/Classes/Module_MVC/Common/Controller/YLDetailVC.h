//
//  YLDetailVC.h
//  WitCity
//
//  Created by simpletour on 16/6/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLViewController.h"
#import "YLToast.h"
#import "YLNewsModel.h"
#import "DDBusListModel.h"
#import "DDNewsModel.h"
#import "DDRecruitModel.h"
#import "DDRentWantModel.h"
#import "DDJobSeekModel.h"
#import "DDZTHomeModel.h"
#import "DDEnterpriseContactModel.h"
#import "DDDataModel.h"
#import "DDEnterpriseModel.h"

@interface YLDetailVC : YLViewController

@property (nonatomic, strong) UIButton  *btnCollect;
@property (nonatomic, strong) UIButton  *btnShare;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, strong) YLNewsModel *model;      //企业版的新闻
@property (nonatomic, strong) DDBusListModel *busModel;//公交车
@property (nonatomic, strong) DDNewsModel *newsModel;  //生活版的新闻
@property (nonatomic, strong) DDRecruitModel *rModel;  //招聘
@property (nonatomic, strong) DDRentWantModel *rwModel;  //求租
@property (nonatomic, strong) DDJobSeekModel *jsModel;  //求职
@property (nonatomic, strong) DDZTHomeModel *nearByModel;  //周边首页
@property (nonatomic, strong) DDEnterpriseContactModel *contactModel;//企业通讯录
@property (nonatomic, strong) DDDataModel *dataModel;   //企业主页
@property (nonatomic, strong) DDEnterpriseModel *enterpriseModel;//企业列表

- (void)initButtonsWithCollectImageNamed:(NSString *)collectImageNamed collectHighlightImageNamed:(NSString *)collectHighlightImageNamed shareImageNamed:(NSString *)shareImageNamed;
- (void)collectClick:(UIButton *)button;
- (void)btnShareClick:(UIButton *)button;

@end
