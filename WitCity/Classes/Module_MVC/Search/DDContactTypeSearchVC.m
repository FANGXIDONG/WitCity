
//
//  DDContactTypeSearchVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/1/4.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDContactTypeSearchVC.h"
#import "YLSearchBar.h"
#import "DDSearchMainView.h"
#import "DDSearchSecVC.h"

@interface DDContactTypeSearchVC ()
@property (nonatomic, strong) YLSearchBar *searchBar;
@property (nonatomic, strong) DDSearchMainView *mainView;
@end

@implementation DDContactTypeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
}

-(void)addViews{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.mainView];
}

-(DDSearchMainView *)mainView{
    
    if(!_mainView) {
        _mainView = [[DDSearchMainView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
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
        case kDDBlockTypeCompany:
        {
            [self pushToNextSearchVC:@"1"];
        }break;
        case kDDBlockTypeRegisterType:
        {
            [self pushToNextSearchVC:@"2"];
        }break;
        case kDDBlockTypeIndustry:
        {
            [self pushToNextSearchVC:@"3"];
        }break;
        case kDDBlockTypeLegalPerson:
        {
            [self pushToNextSearchVC:@"4"];
        }break;
        case kDDBlockTypeBusinessScope:
        {
            [self pushToNextSearchVC:@"5"];
        }break;
        case kDDBlockTypeRegisterCapital:
        {
            [self pushToNextSearchVC:@"6"];
        }break;
        case kYLBlockTypeSearchBarCancel:{
            [self popViewController];
        }break;
        case kYLBlockTypeSearchBarClear:{
//            [self.mainView hideResultView];
        }break;
        case kYLBlockTypeTabChange:{
//            NSString *value = self.searchBar.text;
//            if (value.length > 0) {
//                [self searchResultWithCategoryId:self.mainView.categoryId content:value];
//            }
        }break;
        case kYLBlockTypeSearchBarSearch:{
 
            [YLToast showToastWithView:self.view text:@"请选择以下类型进行搜索"];
        }break;
        default:
            break;
    }
}

#pragma mark  - push

-(void)pushToNextSearchVC:(NSString *)type{
    
    DDSearchSecVC *secVC  = [[DDSearchSecVC alloc] init];
    secVC.type = type;
    [self pushModalWithController:secVC];
}

#pragma mark - other
-(void)popViewController
{
    [self popModalViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
