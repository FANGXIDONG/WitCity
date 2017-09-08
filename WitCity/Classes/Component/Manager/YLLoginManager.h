//
//  YLLoginManager.h
//  HYB
//
//  Created by simpletour on 16/4/26.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLViewController.h"

@interface YLLoginManager : YLViewController

- (instancetype)initWithController:(UIViewController *)controller;

- (void)pushCheckedLoginWithPopToRoot:(BOOL)popToRoot block:(void(^)())block;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure;

@end
