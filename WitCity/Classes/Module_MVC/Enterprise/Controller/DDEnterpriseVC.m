//
//  DDEnterpriseVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/8/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseVC.h"
#import "YLUserHttpUtil.h"
#import "YLLoginManager.h"
#import "DDEnterpriseTableView.h"
#import "YLHomeHttpUtil.h"
#import "DDEnterpriseModel.h"
#import "DDSelectModel.h"
#import "DDConditionFilterView.h"
#import "UIView+MJExtension.h"
#import "YLDefaultDetailVC.h"

@interface DDEnterpriseVC ()
{
    // *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值
    NSArray *_selectedDataSource1Ary;
    NSArray *_selectedDataSource2Ary;
    NSArray *_selectedDataSource3Ary;
    
    DDConditionFilterView *_conditionFilterView;
}
@property (nonatomic, strong) DDEnterpriseTableView *tableView;
@property (nonatomic, strong) YLLoginManager        *loginManager;
@property (nonatomic, strong) NSMutableArray *array;   //企业列表数据
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) NSMutableArray *industryArr;

@end

@implementation DDEnterpriseVC

-(void)viewWillAppear:(BOOL)animated{
        [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业";
    //设置坐标零点从(0,64)算起
    self.navigationController.navigationBar.translucent = YES;
    [self initData];
    [self addViews];
}

-(void)initData{
    
    // 设置初次加载显示的默认数据
    _selectedDataSource1Ary = @[@"注册类型"];
    _selectedDataSource2Ary = @[@"行业类别"];
    _selectedDataSource3Ary = @[@"认证情况"];

    _conditionFilterView = [DDConditionFilterView conditionFilterViewWithFilterBlock:^(BOOL isFilter, NSArray *dataSource1Ary, NSArray *dataSource2Ary, NSArray *dataSource3Ary) {
        if (isFilter) {
            //网络加载请求 存储请求参数
            _selectedDataSource1Ary = dataSource1Ary;
            _selectedDataSource2Ary = dataSource2Ary;
            _selectedDataSource3Ary = dataSource3Ary;
        }else{
            // 不是筛选，全部赋初值（在这个工程其实是没用的，因为tableView是选中后必选的，即一旦选中就没有空的情况，但是如果可以清空筛选条件的时候就有必要 *重新* reset data）
            _selectedDataSource1Ary = @[@"注册类型"];
            _selectedDataSource2Ary = @[@"行业类别"];
            _selectedDataSource3Ary = @[@"认证情况"];
        }
        [self startRequest];
    }];
    _conditionFilterView.y += 64;
    // 传入数据源，对应三个tableView顺序
//    _conditionFilterView.dataAry1 = @[@"有限公司",@"责任公司"];
//    _conditionFilterView.dataAry2 = @[@"电子商务",@"买药"];
//    _conditionFilterView.dataAry3 = @[@"未认证企业",@"已认证企业"];
    
    _typeArr = [NSMutableArray array];
    _industryArr = [NSMutableArray array];
    [YLUserHttpUtil getCompanyRegisterTypeblock:^(NSDictionary *dict) {
        NSArray *typeArr = [DDSelectModel mj_objectArrayWithKeyValuesArray:dict];
        for (DDSelectModel *model in typeArr) {
            [_typeArr addObject:model.name];
        }
    } failure:^{
    }];
    [YLUserHttpUtil getCompanyIndustryblock:^(NSDictionary *dict) {
        NSArray *industryArr = [DDSelectModel mj_objectArrayWithKeyValuesArray:dict];
        for (DDSelectModel *model in industryArr) {
            [_industryArr addObject:model.name];
        }
    } failure:^{
    }];
    _conditionFilterView.dataAry1 = (NSArray *)_typeArr;
    _conditionFilterView.dataAry2 = (NSArray *)_industryArr;
    _conditionFilterView.dataAry3 = @[@"全部",@"未认证企业",@"已认证企业"];
    
    // 初次设置默认显示数据，内部会调用block 进行第一次数据加载
    [_conditionFilterView bindChoseArrayDataSource1:_selectedDataSource1Ary DataSource2:_selectedDataSource2Ary DataSource3:_selectedDataSource3Ary];
    
    [self.view addSubview:_conditionFilterView];
}
- (void)startRequest
{
    NSString *source1 = [NSString stringWithFormat:@"%@",_selectedDataSource1Ary.firstObject];
    NSString *source2 = [NSString stringWithFormat:@"%@",_selectedDataSource2Ary.firstObject];
    NSString *source3 = [NSString stringWithFormat:@"%@",_selectedDataSource3Ary.firstObject];
    NSDictionary *dic = [_conditionFilterView keyValueDic];
    // 可以用字符串在dic换成对应英文key
    
    NSLog(@"\n第一个条件:%@\n  第二个条件:%@\n  第三个条件:%@\n",source1,source2,source3);
    
    [_array removeAllObjects];
    [YLHomeHttpUtil getEnterpriseListWithUser_id:[YLUserSingleton shareInstance].uid reg_type:source1 industry:source2 reg:source3 page:1 block:^(NSDictionary *dict) {
        _array  = [DDEnterpriseModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.tableView dataList:_array withFlag:0 append:nil];
    } failure:^{
    }];
}


-(void)addViews
{
    [self.view addSubview:self.tableView];
}

-(DDEnterpriseTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[DDEnterpriseTableView alloc]initWithFrame:CGRectMake(0, 104, WINDOW_WIDTH, WINDOW_HEIGHT - 104 - 40) style:UITableViewStylePlain];
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
        _loginManager = [[YLLoginManager alloc] initWithController:self];
    }
    return _loginManager;
}
#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [YLHomeHttpUtil getEnterpriseListWithUser_id:[YLUserSingleton shareInstance].uid reg_type:@"" industry:@"" reg:@"" page:page block:^(NSDictionary *dict) {
        _array  = [DDEnterpriseModel mj_objectArrayWithKeyValuesArray:dict];
       [self showDataWithTableView:self.tableView dataList:_array withFlag:0 append:append];
    } failure:^{
    }];
}
#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeEnterprisesDetail:{
            DDEnterpriseModel *model = dict[kYLModel];
            [self pushDefaultDetailVCWithModel:model];
        }break;
        default:
            break;
    }
}
#pragma mark - push
- (void)pushDefaultDetailVCWithModel:(DDEnterpriseModel *)model
{
    YLDefaultDetailVC *vc = [[YLDefaultDetailVC alloc] init];
    vc.enterpriseModel = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end






