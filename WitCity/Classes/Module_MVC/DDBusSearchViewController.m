//
//  DDBusSearchViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDBusSearchViewController.h"
#import "YLSearchBar.h"
#import "DDTravelTableView.h"
#import "DDLifeHttpUtil.h"
#import "DDBusListModel.h"
#import "DDDefaultVC.h"

@interface DDBusSearchViewController ()

@property (nonatomic, strong) YLSearchBar *searchBar;
@property (nonatomic, strong) DDTravelTableView *busTableView;
@end

@implementation DDBusSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addViews];
    
}

-(void)addViews
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.busTableView];
}

#pragma mark - getter


-(DDTravelTableView *)busTableView
{
    if(!_busTableView) {
        _busTableView = [[DDTravelTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        _busTableView.flag = 1;
        WS(wself);
        _busTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _busTableView;
}

-(YLSearchBar *)searchBar
{
    if(!_searchBar) {
        _searchBar = [[YLSearchBar alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 30)];
        WS(wself);
        _searchBar.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _searchBar;
}


#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypeSearchBarCancel:{
            [self popViewController];
        }break;
        case kYLBlockTypeSearchBarClear:{
//            [self.mainView hideResultView];
        }break;
        case kYLBlockTypeTabChange:{
            NSString *value = self.searchBar.text;
            if (value.length > 0) {
                [self searchResultWithContent:value];
            }
        }break;
        case kYLBlockTypeSearchBarSearch:{
            NSString *value = dict[kYLValue];
            [self searchResultWithContent:value];
        }break;
        case kDDBlockTypeLifeBus:{
            DDBusListModel *model = dict[kYLModel];
            [self pushDefaultDetailVCWithModel:model];
        }break;
//        case kDDBlockTypeLifeBusSearch:
//        {
//            NSLog(@"。。。");
//        }
        default:
            break;
    }
}


#pragma mark - server
- (void)searchResultWithContent:(NSString *)content
{
    [DDLifeHttpUtil getBusSearchResultWithKeyword:content page:1 block:^(NSDictionary *dict) {
        NSArray *array = [DDBusListModel mj_objectArrayWithKeyValuesArray:dict];
        if (array.count > 0) {
            [self.searchBar resignFirstResponder];
//            [self.busTableView updateWithArray:array];
            [self showDataWithTableView:self.busTableView dataList:array withFlag:0 append:nil];
        }
        else{
            [YLToast showToastWithView:self.view text:@"无相关结果"];
            self.busTableView.hidden = YES;
        }
    } failure:^{
        //
    }];

}

#pragma mark - push
- (void)pushDefaultDetailVCWithModel:(DDBusListModel *)model
{
    DDDefaultVC *vc = [[DDDefaultVC alloc] init];
    vc.busModel = model;
    vc.flag = @"公交详情";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
