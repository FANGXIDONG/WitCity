//
//  YLShareManager.h
//  HYB
//
//  Created by duyulong on 16/4/30.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"
#import "YLNewsModel.h"
#import "DDNewsModel.h"
#import "DDEnterpriseContactModel.h"

@interface YLShareManager : NSObject

-(instancetype)initWithController:(UIViewController *)controller;
-(void)shareWithNameKey:(NSString *)nameKey model:(YLModel *)model block:(void(^)())block;

@end
