//
//  YLCommentVC.m
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCommentVC.h"

#import "YLCommentTableView.h"
#import "YLCommentFooterView.h"
#import "YLHomeHttpUtil.h"
#import "YLNewsModel.h"
#import "YLCommentModel.h"
#import "YLUserHttpUtil.h"
#import "YLLoginVC.h"
#import "YLLoginManager.h"

@interface YLCommentVC ()

@property (nonatomic, strong) YLCommentHeaderView *headerView;
@property (nonatomic, strong) YLCommentTableView  *tableView;
@property (nonatomic, strong) YLCommentFooterView *footerView;
@property (nonatomic, copy) NSString              *replyId;
@property (nonatomic, strong) YLLoginManager     *loginManager;

@end

@implementation YLCommentVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@""];
    [self addViews];
    [self loadData];
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.footerView];
    [self.headerView updateWithModel:self.model];
    self.tableView.tableHeaderView = self.headerView;
    self.btnCollect.selected = self.model.status.integerValue;
}

#pragma mark - getter
-(YLCommentHeaderView *)headerView
{
    if(!_headerView) {
        _headerView = [[YLCommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kYLCommentHeaderHeight)];
        _headerView.type = self.type;
    }
    return _headerView;
}

-(YLCommentTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLCommentTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - kYLCommentFooterHeight) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

-(YLCommentFooterView *)footerView
{
    if(!_footerView) {
        _footerView = [[YLCommentFooterView alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT2 - kYLCommentFooterHeight, WINDOW_WIDTH, kYLCommentFooterHeight)];
        WS(wself);
        _footerView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _footerView;
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
        case kYLBlockTypeCommentSend:{
            NSString *content = dict[kYLValue];
            [self replyWithContent:content];
        }break;
        case kYLBlockTypeCommentReply:{
            YLCommentModel *model = dict[kYLModel];
            NSString *placeholder = [NSString stringWithFormat:@"回复@%@:", model.rname];
            self.replyId = model.reply_id.stringValue;
            self.footerView.placeholder = placeholder;
            [self.footerView.textField becomeFirstResponder];
        }break;
        default:
            break;
    }
}

#pragma mark - server
- (void)loadData
{
    [YLHomeHttpUtil interactionDetailWithId:self.model.content_id block:^(NSDictionary *dict) {
        if (![dict isKindOfClass:[NSArray class]]) {
            NSArray *array = [YLCommentModel mj_objectArrayWithKeyValuesArray:dict[@"reply"]];
            [self.tableView updateWithArray:array];
        }
    } failure:^{
    }];
}

- (void)replyWithContent:(NSString *)content
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{        
        [YLUserHttpUtil replyWithReplyId:self.replyId cid:self.model.content_id content:content block:^(NSDictionary *dict) {
            [YLToast showToastInKeyWindowWithText:self.replyId.length > 0 ? @"回复成功" :@"评论成功"];
        } failure:^{
        }];
    }];
}

#pragma mark - push


#pragma mark - other
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


@end
