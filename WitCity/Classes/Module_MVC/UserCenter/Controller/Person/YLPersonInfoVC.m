//
//  YLPersonInfoVC.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPersonInfoVC.h"
#import "YLPersonInfoTableView.h"
#import "YLPhotoManager.h"
#import "YLPersonInfoFooterView.h"
#import "YLPersonEditVC.h"
#import "YLLoginVC.h"
#import "YLUserHttpUtil.h"
#import "YLUserSingleton.h"

@interface YLPersonInfoVC ()

@property (nonatomic, strong) YLPersonInfoTableView *tableView;
@property (nonatomic, strong) YLPersonInfoFooterView *footerView;
@property (nonatomic, strong) YLPhotoManager *manager;

@end

@implementation YLPersonInfoVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"个人信息"];
    [self addViews];
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footerView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - getter
-(YLPersonInfoTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[YLPersonInfoTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

-(YLPersonInfoFooterView *)footerView
{
    if(!_footerView) {
        _footerView = [[YLPersonInfoFooterView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kFooterViewHeight)];
        WS(wself);
        _footerView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _footerView;
}

-(YLPhotoManager *)manager
{
    if(!_manager) {
        _manager = [[YLPhotoManager alloc]initWithController:self];
        WS(wself);
        _manager.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _manager;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypePhotoOption:{//弹出拍照和相册的action sheet
            [self.manager showOptionActionSheet];
        }break;
        case kYLBlockTypePhotoCamera:{//拍照
            [self.manager getPhotoWithCamera];
        }break;
        case kYLBlockTypePhotoLibrary:{//相册
            [self.manager getPhotoWithLibrary];
        }break;
        case kYLBlockTypePhotoResult:{//拍照和相册中选择的图片
            UIImage *image = dict[kYLValue];
            if (image) {
                self.tableView.image = image;
                [self postAvatarWithImage:image];
            }
        }break;
        case kYLBlockTypePersonInfoNickname:{//更改昵称
            [self pushPersonEditWithTyep:kYLPersonEditTypeNickname];
        }break;
        case kYLBlockTypePersonInfoPhone:{//更改电话号码
//            [self pushPersonEditWithTyep:kYLPersonEditTypePhone];
            [YLToast showToastWithView:self.view text:@"不能更改电话号码"];
        }break;
        case kYLBlockTypePersonInfoChangePassword:{//修改密码
            [self pushPersonEditWithTyep:kYLPersonEditTypePassword];
        }break;
        case kYLBlockTypeLoginout:{//安全登出
            [self logoutRequest];
        }break;
            
        default:
            break;
    }

}

#pragma mark - server

//注销
- (void)logoutRequest
{
    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"确定要退出吗" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
        NSLog(@"点击index====%ld",(long)clickIndex);
        
        if (clickIndex == 1) {
            
            [UD removeObjectForKey:@"username"];
            [UD removeObjectForKey:@"password"];
            [[YLUserSingleton shareInstance] clearUserInfo];
            [ND postNotificationName:kUpdateUserInfoNotification object:nil];
            [self pushLoginVC];
            //    [YLUserHttpUtil logoutWithBlock:^(NSDictionary *dict) {
            //        [self pushLoginVC];
            //    } failure:^{
            //    }];
            
        }
    }];
    alert.animationStyle=LXASAnimationTopShake;
    [alert showLXAlertView];

}

- (void)postAvatarWithImage:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.2f);
    UIImage *img = [UIImage imageWithData:data];
    [YLToast showToastWithView:self.view];
    [YLUserHttpUtil uploadAvatarWithImage:img block:^(NSString *avatar) {
        [YLToast hiddenToastWithView:self.view];
    }];
}

#pragma mark - push
//编辑资料
- (void)pushPersonEditWithTyep:(YLPersonEditType)type
{
    YLPersonEditVC *vc = [[YLPersonEditVC alloc]init];
    vc.type = type;
    WS(ws);
    vc.allBlock = ^(NSDictionary *dict) { [ws.tableView reloadData];};
    [self.navigationController pushViewController:vc animated:YES];
}

//退出登录
- (void)pushLoginVC
{
    YLLoginVC *vc = [[YLLoginVC alloc]init];
    vc.isPopToRoot = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - other



@end
