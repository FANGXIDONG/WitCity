//
//  YLCollectManager.h
//  WitCity
//
//  Created by simpletour on 16/6/15.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YLCollectManager : NSObject

- (instancetype)initWithController:(UIViewController *)controller;

- (void)collectWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure;
- (void)collectCancelWithContentId:(NSString *)contentId categoryId:(NSString *)categoryId block:(void(^)(NSDictionary *dict))block failure:(void(^)())failure;

@end
