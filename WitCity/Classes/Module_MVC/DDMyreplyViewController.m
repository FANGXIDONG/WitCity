
//
//  DDMyreplyViewController.m
//  WitCity
//
//  Created by 方冬冬 on 2016/11/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyreplyViewController.h"
#import "DDMyreplyTableView.h"
#import "DDMyreplyModel.h"

@interface DDMyreplyViewController ()
@property (nonatomic,  strong) DDMyreplyTableView *tableView;
@end

@implementation DDMyreplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
}

-(void)addViews{
    [self.view addSubview:self.tableView];
}
-(DDMyreplyTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[DDMyreplyTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
    }
    return _tableView;
}
#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil myReplyMessagesWithUid:[YLUserSingleton shareInstance].uid page:page block:^(NSDictionary *dict) {
        NSArray *array = [DDMyreplyModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.tableView dataList:array withFlag:0 append:append];
    } failure:^{
        //
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
