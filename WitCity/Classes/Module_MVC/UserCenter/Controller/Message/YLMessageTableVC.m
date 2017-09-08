//
//  YLMessageTableVC.m
//  WitCity
//
//  Created by duyulong on 16/5/31.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLMessageTableVC.h"
#import "YLMessageTableView.h"
#import "YLUserHttpUtil.h"
#import "YLNewsModel.h"
#import "YLCommentVC.h"

@interface YLMessageTableVC ()

@property (nonatomic, strong) YLMessageTableView *tableView;

@end

@implementation YLMessageTableVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
    self.noneDataType = kYLNoneDataViewTypeMessage;
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
}

#pragma mark - getter
-(YLMessageTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLMessageTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
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
            [self pushCommentVCWithModel:model];
        }break;
        default:
            break;
    }
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    if (self.index == 0) {
        [self invitationListWithPage:page append:append];
    } else if (self.index == 1) {
        [self replyListWithPage:page append:append];
    } else {
        [self sysMsgListWithPage:page append:append];
    }
}

//我的发帖列表
- (void)invitationListWithPage:(NSInteger)page append:(BOOL)append
{
    [YLUserHttpUtil invitationListWithPage:page block:^(NSDictionary *dict) {
        NSArray *array = [YLNewsModel mj_objectArrayWithKeyValuesArray:dict];
        NSLog(@"fatie array = %@", array);
        [self showDataWithTableView:self.tableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

//我的回复列表
- (void)replyListWithPage:(NSInteger)page append:(BOOL)append
{
    [YLUserHttpUtil replyListWithPage:page block:^(NSDictionary *dict) {
        NSArray *array = [YLNewsModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.tableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}

//系统消息列表
- (void)sysMsgListWithPage:(NSInteger)page append:(BOOL)append
{
    [YLUserHttpUtil sysMsgListWithPage:page block:^(NSDictionary *dict) {
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
    vc.categoryId = @"18";
    vc.type = kYLCommetnHeaderTypeNotice;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - other



@end
