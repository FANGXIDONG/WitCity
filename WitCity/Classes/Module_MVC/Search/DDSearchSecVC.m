//
//  DDSearchSecVC.m
//  WitCity
//
//  Created by 刘帅 on 17/1/4.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDSearchSecVC.h"
#import "YLSearchBar.h"
#import "DDSearchSecTableView.h"
#import "DDEnterpriseContactModel.h"
#import "ScopeOfFundsView.h"
#import "DDDefaultVC.h"

@interface DDSearchSecVC ()

@property (nonatomic, strong) YLSearchBar               *searchBar;
@property (nonatomic, strong) DDSearchSecTableView      *secTableView;
@property (nonatomic, strong) ScopeOfFundsView          *scopeoffundsview;

@end

@implementation DDSearchSecVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
}

-(void)addViews
{
    self.navigationItem.hidesBackButton = NO;
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.leftBarButtonItem = [self buttonForPublishVCNavigationBarWithAction:@selector(leftClick) imageNamed:@"navi_back"];
    
    [self.view addSubview:self.secTableView];
    if ([self.type isEqualToString:@"6"]) {
        [self popScopeView];
    }
}
- (void)popScopeView {
    [UIView animateWithDuration:1 animations:^{
        [self.view addSubview:self.scopeoffundsview];
    }];
}
- (void)postContacts:(NSNotification *)nf{
    [self.scopeoffundsview removeFromSuperview];
    NSString *content = nf.object;
    [self searchResultWithCategoryId:self.type content:content];
}

#pragma mark - getter

- (ScopeOfFundsView *)scopeoffundsview{
    if(!_scopeoffundsview) {
        _scopeoffundsview = [[ScopeOfFundsView alloc]initWithFrame:CGRectMake(50, 0, WINDOW_WIDTH/2, CONTENT_HEIGHT2/6)];
        WS(wself);
        _scopeoffundsview.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    [ND addObserver:self selector:@selector(postContacts:) name:@"ScopeOfFundsPost" object:nil];
    return _scopeoffundsview;
    
}


-(DDSearchSecTableView *)secTableView
{
    if(!_secTableView) {
        _secTableView = [[DDSearchSecTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _secTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _secTableView;
}

-(YLSearchBar *)searchBar
{
    if(!_searchBar) {
        _searchBar = [[YLSearchBar alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 30)];
        WS(wself);
        _searchBar.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
        switch ([self.type integerValue]) {
            case 1:
                [_searchBar setSearchBarIcon:@"icon_company"];
                break;
            case 2:
                [_searchBar setSearchBarIcon:@"icon_rType"];
                break;
            case 3:
                [_searchBar setSearchBarIcon:@"icon_instury"];
                break;
            case 4:
                [_searchBar setSearchBarIcon:@"icon_faren"];
                break;
            case 5:
                [_searchBar setSearchBarIcon:@"icon_runRange"];
                break;
            case 6:
                [_searchBar setSearchBarIcon:@"icon_rAccount"];
                break;
                
            default:
                break;
        }
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
            //[self.mainView hideResultView];
        }break;
        case kYLBlockTypeTabChange:{
            NSString *value = self.searchBar.text;
            if (value.length > 0) {
                [self searchResultWithCategoryId:self.type content:value];
            }
        }break;
        case kYLBlockTypeSearchBarSearch:{
            NSString *value = dict[kYLValue];
            [self searchResultWithCategoryId:self.type content:value];
        }break;
        case kYLBlockTypeSearchTag:{
            NSString *value = dict[kYLValue];
            
            self.searchBar.text = value;
            [self searchResultWithCategoryId:self.type content:value];
        }break;
        case kDDBlockTypeEnterpriseContactDeatil:
        {
            DDEnterpriseContactModel *model = dict[kYLModel];
            [self pushCommentVCWithModel:model];
        }break;
        default:
            break;
    }
}


#pragma mark - server
- (void)searchResultWithCategoryId:(NSString *)categoryId content:(NSString *)content
{
    [YLToast showToastWithView:self.view text:@"搜索中"];
    [YLHomeHttpUtil searchContactsWithKey:content type:categoryId block:^(NSDictionary *dict) {
        [YLToast hiddenToastWithView:self.view];
        NSArray *array = [DDEnterpriseContactModel mj_objectArrayWithKeyValuesArray:dict];
        if (array.count > 0) {
            [self.secTableView updateWithArray:array];
        } else {
            [YLToast showToastWithView:self.view text:@"无相关结果"];
        }
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



#pragma mark - other
-(void)popViewController
{
    [self popModalViewController];
}
-(void)leftClick{
    [self popModalViewController];
}

@end
