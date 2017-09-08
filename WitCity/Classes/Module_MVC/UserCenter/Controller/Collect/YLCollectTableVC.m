//
//  YLCollectTableVC.m
//  WitCity
//
//  Created by simpletour on 16/5/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCollectTableVC.h"
#import "YLCollectTableView.h"
#import "YLUserHttpUtil.h"
#import "YLNewsModel.h"
#import "YLCommentVC.h"
#import "YLDefaultDetailVC.h"
#import "YLEnterpriseDetailVC.h"

@interface YLCollectTableVC ()

@property (nonatomic, strong) YLCollectTableView *tableView;

@end

@implementation YLCollectTableVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
    self.noneDataType = kYLNoneDataViewTypeCollect;
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
}

#pragma mark - getter
-(YLCollectTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLCollectTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        _tableView.index = self.index;
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypeNewsDetail:{
            YLNewsModel *model = dict[kYLModel];
            if (self.index == 0) {
                [self pushEnterpriseDetailVCWithModel:model];
            } else if (self.index < 3) {
                [self pushDefaultDetailVCWithModel:model];
            } else {
                [self pushCommentVCWithModel:model];
            }
        }break;
        default:
            break;
    }
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [YLUserHttpUtil collectListWithCategoryId:self.model.category_id page:page block:^(NSDictionary *dict) {
        NSArray *array = [YLNewsModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.tableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

#pragma mark - push
- (void)pushCommentVCWithModel:(YLNewsModel *)model
{
    YLCommentVC *vc = [[YLCommentVC alloc]init];
    vc.model = model;
    vc.categoryId = self.model.category_id;
    vc.type = [self.model.category_id isEqualToString:@"19"] ?  kYLCommetnHeaderTypeForum : kYLCommetnHeaderTypeNotice;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushDefaultDetailVCWithModel:(YLNewsModel *)model
{
    YLDefaultDetailVC *vc = [[YLDefaultDetailVC alloc] init];
    vc.model = model;
    vc.categoryId = self.model.category_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushEnterpriseDetailVCWithModel:(YLNewsModel *)model
{
    YLEnterpriseDetailVC *vc = [[YLEnterpriseDetailVC alloc]init];
    vc.model = model;
    vc.categoryId = self.model.category_id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - other




@end
