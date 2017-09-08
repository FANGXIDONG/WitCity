//
//  YLLoginManager.m
//  HYB
//
//  Created by simpletour on 16/4/26.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLLoginManager.h"
#import "YLLoginVC.h"
#import "YLUserSingleton.h"
#import "YLUserHttpUtil.h"

@interface YLLoginManager ()

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation YLLoginManager

- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    return self;
}


- (void)pushCheckedLoginWithPopToRoot:(BOOL)popToRoot block:(void(^)())block
{
    if ([YLUserSingleton shareInstance].uid.length > 0) {
        block();
    } else {
        YLLoginVC *vc = [[YLLoginVC alloc]init];
        vc.isPopToRoot = popToRoot;
        vc.hidesBottomBarWhenPushed = YES;
        [self.controller.navigationController pushViewController:vc animated:YES];
    }
}


- (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure
{
    [YLUserHttpUtil loginWithUsername:username password:password block:^(NSDictionary *dict) {
        [UD setObject:username forKey:@"username"];
        [UD setObject:password forKey:@"password"];
        block(dict);
    } failure:^{
        failure();
    }];
}

@end
