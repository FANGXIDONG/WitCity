//
//  DDEnterpriseContactsVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/1/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseContactsVC.h"
#import "DDEpCategoryModel.h"
#import "DDEnterpriseContactModel.h"
#import "DDEpContactTableView.h"   
#import "YLLoginManager.h"
#import "DDDefaultVC.h"

@interface DDEnterpriseContactsVC ()
@property (nonatomic, strong) DDEpContactTableView *tableView;
@property (nonatomic, strong) YLLoginManager    *loginManager;
@end

@implementation DDEnterpriseContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
    if (_enterFlag == 1) {
        [self navigationWithTitle:@"企业通讯录"];
    }else{
    }
}
-(void)addViews
{
    [self.view addSubview:self.tableView];
}
#pragma mark - getter
-(DDEpContactTableView *)tableView
{
    float tableHeight = 0;
    if (_enterFlag == 1) {
        tableHeight = CONTENT_HEIGHT2;
    }else{
        tableHeight = CONTENT_HEIGHT;
    }
    if(!_tableView) {
        _tableView = [[DDEpContactTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, tableHeight) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeEnterpriseContactDeatil: {
            DDEnterpriseContactModel *model = dict[kYLModel];
            [self pushCommentVCWithModel:model];
        }break;
        default:
            break;
    }
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [YLToast showToastWithView:self.view];
    [YLHomeHttpUtil enterpriseContactsListBlock:^(NSDictionary *dict) {
        [YLToast hiddenToastWithView:self.view];
        NSArray *array = [DDEpCategoryModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.tableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

#pragma mark - push
- (void)pushCommentVCWithModel:(DDEnterpriseContactModel *)model
{
    DDDefaultVC *mVC = [[DDDefaultVC alloc] init];
    mVC.flag = @"企业通讯录";
    mVC.contactModel = model;
    mVC.hidesBottomBarWhenPushed     =YES;
    [self.navigationController pushViewController:mVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
