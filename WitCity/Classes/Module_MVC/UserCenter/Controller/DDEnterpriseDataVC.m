
//
//  DDEnterpriseDataVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/19.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseDataVC.h"
#import "DDEnterpriseDataView.h"
#import "DDEnterpriseEditVC.h"
#import "DDEnterpriseHomepageVC.h"
#import "YLUserHttpUtil.h"
#import "DDDataModel.h" 

@interface DDEnterpriseDataVC ()
@property (nonatomic, strong) DDEnterpriseDataView *dataView;
@property (nonatomic, strong) DDDataModel *model;
@end

@implementation DDEnterpriseDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"企业资料"];
    self.navigationItem.rightBarButtonItem = [self buttonForNavigationBarWithAction:@selector(editdataClick) title:@"修改"];
    [self addViews];
    [self loadData];
}
-(void)loadData{
    
    [YLUserHttpUtil getEnterpriseDatablock:^(NSDictionary *dict) {
        _model = [DDDataModel mj_objectWithKeyValues:dict];
        _dataView.model = _model;
    } failure:^{
        
    }];
}
-(void)addViews{
    [self.view addSubview:self.dataView];
}

-(DDEnterpriseDataView *)dataView{
    if (!_dataView) {
        _dataView = [[DDEnterpriseDataView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    WS(wself);
    _dataView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _dataView;
}
#pragma mark  - callback
-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeEnterpriseHomePage:{
            //查看生成的主页
            [self enterpriseHomepage];
            
        }break;
        default:
            break;
    }
}
-(void)enterpriseHomepage{
    DDEnterpriseHomepageVC *vc = [[DDEnterpriseHomepageVC alloc] init];
    vc.dataModel = _model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)editdataClick{
    DDEnterpriseEditVC *editVC = [[DDEnterpriseEditVC alloc] init];
    editVC.titleString = @"修改";
    editVC.dataModel = _model;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end








