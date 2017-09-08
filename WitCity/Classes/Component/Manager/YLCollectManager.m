//
//  YLCollectManager.m
//  WitCity
//
//  Created by simpletour on 16/6/15.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCollectManager.h"
#import "YLUserHttpUtil.h"
#import "YLToast.h"

@interface YLCollectManager ()

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation YLCollectManager

- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    return self;
}

- (void)collectWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure
{
    [YLUserHttpUtil collectWithContentId:contentId categoryId:categoryId block:^(NSDictionary *dict) {
        [YLToast showToastInKeyWindowWithText:@"收藏成功"];
        block(dict);
    } failure:^{
        failure();
    }];
}

- (void)collectCancelWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure
{
    [YLUserHttpUtil collectCancelWithContentId:contentId categoryId:categoryId block:^(NSDictionary *dict) {
        [YLToast showToastInKeyWindowWithText:@"取消收藏成功"];
        block(dict);
    } failure:^{
        failure();
    }];
}

@end
