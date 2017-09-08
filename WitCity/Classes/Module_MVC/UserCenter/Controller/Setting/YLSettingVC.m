//
//  YLSettingVC.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLSettingVC.h"
#import "YLSettingTableView.h"
#import "YLAboutVC.h"
#import <SDWebImage/SDImageCache.h>

@interface YLSettingVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) YLSettingTableView *tableView;

@end

@implementation YLSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"设置"];
    [self addViews];
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
}

-(YLSettingTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLSettingTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        _tableView.versionStr = self.version;
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypeSettingClearCache:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要清理缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }break;
        case kYLBlockTypeSettingAbout:{
            [self pushAboutVC];
        }break;
        default:
            break;
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(1 == buttonIndex) {
        [YLToast showToastWithView:self.view];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [YLToast hiddenToastWithView:self.view];
            [self.tableView reloadData];
        }];
    }
}

- (void)pushAboutVC
{
    YLAboutVC *vc = [[YLAboutVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
