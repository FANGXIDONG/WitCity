//
//  YLSearchVC.m
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSearchVC.h"
#import "YLSearchMainView.h"
#import "YLScrollTabs.h"
#import "YLSearchBar.h"
#import "YLHomeHttpUtil.h"
#import "YLNewsModel.h"
#import "YLDefaultDetailVC.h"
#import "YLCommentVC.h"

@interface YLSearchVC ()

@property (nonatomic, strong) YLSearchBar *searchBar;
@property (nonatomic, strong) YLSearchMainView *mainView;

@end

@implementation YLSearchVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
}

-(void)addViews
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.mainView];
}

#pragma mark - getter

-(YLSearchMainView *)mainView
{
    if(!_mainView) {
        _mainView = [[YLSearchMainView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _mainView;
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
            [self.mainView hideResultView];
        }break;
        case kYLBlockTypeTabChange:{
            NSString *value = self.searchBar.text;
            if (value.length > 0) {
                [self searchResultWithCategoryId:self.mainView.categoryId content:value];
            }
        }break;
        case kYLBlockTypeSearchBarSearch:{
            NSString *value = dict[kYLValue];
            [self searchResultWithCategoryId:self.mainView.categoryId content:value];
        }break;
        case kYLBlockTypeSearchTag:{
            NSString *value = dict[kYLValue];
            self.searchBar.text = value;
            [self searchResultWithCategoryId:self.mainView.categoryId content:value];
        }break;
        case kYLBlockTypeNewsDetail:{
            YLNewsModel *model = dict[kYLModel];
            if ([self.mainView.categoryId isEqualToString:@"18"]) {
                [self pushCommentVCWithModel:model type:kYLCommetnHeaderTypeNotice];
            } else if ([self.mainView.categoryId isEqualToString:@"19"]) {
                [self pushCommentVCWithModel:model type:kYLCommetnHeaderTypeForum];
            } else {
                [self pushDefaultDetailVCWithModel:model];
            }
        }break;
        default:
            break;
    }
}

#pragma mark - server
- (void)searchResultWithCategoryId:(NSString *)categoryId content:(NSString *)content
{
    [YLHomeHttpUtil searchResultWithKey:content cid:categoryId page:1 block:^(NSDictionary *dict) {
        NSArray *array = [YLNewsModel mj_objectArrayWithKeyValuesArray:dict];
        if (array.count > 0) {
            [self.searchBar resignFirstResponder];
            [self.mainView showResultViewWithArray:array];
        } else {
            [YLToast showToastWithView:self.view text:@"无相关结果"];
            [self.mainView hideResultView];
        }
    } failure:^{
    }];
}

#pragma mark - push
- (void)pushDefaultDetailVCWithModel:(YLNewsModel *)model
{
    YLDefaultDetailVC *vc = [[YLDefaultDetailVC alloc] init];
    vc.model = model;
    vc.categoryId = self.mainView.categoryId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushCommentVCWithModel:(YLNewsModel *)model type:(YLCommetnHeaderType)type
{
    YLCommentVC *vc = [[YLCommentVC alloc]init];
    vc.model = model;
    vc.categoryId = self.mainView.categoryId;
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - other
-(void)popViewController
{
    [self popModalViewController];
}




@end
